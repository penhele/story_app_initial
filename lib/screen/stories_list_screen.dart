import 'package:flutter/material.dart';

import '../model/story.dart';

class StoriesListScreen extends StatelessWidget {
  final List<Story> stories;
  final Function(String) onTapped;

  const StoriesListScreen({
    super.key,
    required this.stories,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stories App")),
      body: ListView(
        children: [
          for (var story in stories)
            ListTile(
              title: Text(story.author),
              subtitle: Text(story.story),
              isThreeLine: true,
              onTap: () => onTapped(story.id),
            ),
        ],
      ),
    );
  }
}
