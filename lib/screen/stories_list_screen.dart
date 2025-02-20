import 'package:flutter/material.dart';

import '../model/story.dart';

class StoriesListScreen extends StatelessWidget {
  final List<Story> quotes;

  const StoriesListScreen({super.key, required this.quotes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stories App")),
      body: ListView(
        children: [
          for (var quote in quotes)
            ListTile(
              title: Text(quote.author),
              subtitle: Text(quote.quote),
              isThreeLine: true,
            ),
        ],
      ),
    );
  }
}
