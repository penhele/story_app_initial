import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_initial/provider/auth_provider.dart';

import '../model/story.dart';

class StoriesListScreen extends StatelessWidget {
  final List<Story> stories;
  final Function(String) onTapped;
  final Function() onLogout;

  const StoriesListScreen({
    super.key,
    required this.stories,
    required this.onTapped,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final authWatch = context.watch<AuthProvider>();

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final authRead = context.read<AuthProvider>();
          final result = await authRead.logout();
          if (result) onLogout();
        },
        tooltip: "Logout",
        child:
            authWatch.isLoadingLogout
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.logout),
      ),
    );
  }
}
