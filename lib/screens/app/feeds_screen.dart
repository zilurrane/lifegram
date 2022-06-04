import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lifegram/models/feed.dart';
import 'package:http/http.dart' as http;
import 'package:lifegram/shared/constants/env_constants.dart';

List<Feed> parseFeeds(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Feed>((json) => Feed.fromJson(json)).toList();
}

Future<List<Feed>> fetchFeeds() async {
  final response = await http
      .get(Uri.parse('${EnvConstants.apiUrl}/posts'), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode == 200) {
    return compute(parseFeeds, response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Feed>>(
            future: fetchFeeds(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return FeedList(feeds: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class FeedList extends StatelessWidget {
  const FeedList({Key? key, required this.feeds}) : super(key: key);

  final List<Feed>? feeds;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: feeds?.length,
      itemBuilder: (context, index) {
        return Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 239, 241, 255)),
            padding: const EdgeInsets.all(15.0),
            child: FeedItem(story: feeds?[index]));
      },
    );
  }
}

class FeedItem extends StatelessWidget {
  const FeedItem({Key? key, required this.story}) : super(key: key);

  final Feed? story;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(children: [
                  Text(
                    story?.author?.name ?? 'Zilu',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w900),
                  )
                ])),
          ),
          Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.grey),
              child: Image.network('https://i.imgur.com/o8NXruv.png',
                  height: 200)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: Row(children: [
                Text(
                  story?.text ?? '',
                  style: const TextStyle(fontSize: 12),
                )
              ]))
        ],
      ),
    );
  }
}
