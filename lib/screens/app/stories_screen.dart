import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lifegram/models/story.dart';

List<Story> parseStories(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Story>((json) => Story.fromJson(json)).toList();
}

Future<List<Story>> fetchStories() async {
  final String response = await rootBundle.loadString('json/stories.json');
  return compute(parseStories, response);
}

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({Key? key}) : super(key: key);

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("posts").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          return StoryList(stories: snapshot.data?.docs);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}

class StoryList extends StatelessWidget {
  const StoryList({Key? key, required this.stories}) : super(key: key);

  final List<QueryDocumentSnapshot<Object?>>? stories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stories?.length,
      itemBuilder: (context, index) {
        return Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 239, 241, 255)),
            padding: const EdgeInsets.all(15.0),
            child: StoryItem(story: stories?[index]));
      },
    );
  }
}

class StoryItem extends StatelessWidget {
  const StoryItem({Key? key, required this.story}) : super(key: key);

  final QueryDocumentSnapshot<Object?>? story;

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
                    story?['author']['name'] ?? '',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w900),
                  )
                ])),
          ),
          Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.grey),
              child: Image.network(story?['images']?[0]['url'] ?? '',
                  height: 200)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: Row(children: [
                Text(
                  story?['caption'] ?? '',
                  style: const TextStyle(fontSize: 12),
                )
              ]))
        ],
      ),
    );
  }
}
