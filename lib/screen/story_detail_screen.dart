import 'package:flutter/material.dart';

import '../model/story.dart';

class StoryDetailScreen extends StatelessWidget {
  final String storyId;

  const StoryDetailScreen({super.key, required this.storyId});

  @override
  Widget build(BuildContext context) {
    final story = stories.singleWhere((element) => element.id == storyId);
    return Scaffold(
      appBar: AppBar(title: Text(story.author)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(story.author, style: Theme.of(context).textTheme.titleLarge),
            Text(story.story, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
