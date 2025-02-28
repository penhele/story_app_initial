import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screen/home/story_list_widget.dart';
import '../../provider/auth_provider.dart';
import '../../provider/story_list_provider.dart';
import '../../static/story_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) onTapped;
  final Function() onLogout;

  const HomeScreen({super.key, required this.onTapped, required this.onLogout});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<StoryListProvider>(context, listen: false).fetchStoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authWatch = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Story App"), centerTitle: true),
      body: Consumer<StoryListProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            StoryListLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            StoryListLoadedState(data: var storyList) => ListView.builder(
              itemCount: storyList.length,
              itemBuilder: (context, index) {
                final story = storyList[index];

                return StoryListWidget(
                  story: story,
                  onTap: () => widget.onTapped(story.id),
                );
              },
            ),
            StoryListErrorState() => const Center(child: Text('error bos')),
            _ => const Center(child: Text('tidak ada data bos')),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final authRead = context.read<AuthProvider>();
          final result = await authRead.logout();
          if (result) widget.onLogout();
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
