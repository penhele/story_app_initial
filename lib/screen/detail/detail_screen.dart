import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screen/detail/body_of_detail_widget.dart';
import '../../provider/story_detail_provider.dart';
import '../../static/story_detail_result_state.dart';

class DetailScreen extends StatefulWidget {
  final String storyId;

  const DetailScreen({super.key, required this.storyId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<StoryDetailProvider>(
        context,
        listen: false,
      ).fetchStoryDetail(widget.storyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Story Detail"), centerTitle: true),
      body: Consumer<StoryDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            StoryDetailLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            StoryDetailLoadedState(data: var story) => BodyOfDetailWidget(
              story: story,
            ),
            StoryDetailErrorState(error: var message) => Text(message),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
