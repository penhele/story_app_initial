import 'package:flutter/material.dart';
import 'package:story_app_initial/screen/stories_list_screen.dart';

import 'model/story.dart';

void main() {
  runApp(const StoriesApp());
}

class StoriesApp extends StatelessWidget {
  const StoriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stories App',
      home: StoriesListScreen(
        quotes: quotes,
      ),
    );
  }
}