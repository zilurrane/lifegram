import 'dart:convert';

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
        body: Container(
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 239, 241, 255)),
      padding: const EdgeInsets.all(15.0),
      child: FutureBuilder<List<Story>>(
        future: fetchStories(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return StoryList(stories: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    ));
  }
}

class StoryList extends StatelessWidget {
  const StoryList({Key? key, required this.stories}) : super(key: key);

  final List<Story> stories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stories.length,
      itemBuilder: (context, index) {
        return StoryItem(story: stories[index]);
      },
    );
  }
}

class StoryItem extends StatelessWidget {
  const StoryItem({Key? key, required this.story}) : super(key: key);

  final Story story;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(story.caption ?? ''));
  }
}
