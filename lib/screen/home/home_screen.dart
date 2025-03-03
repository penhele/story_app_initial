import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app_initial/provider/home_provider.dart';
import '../../screen/home/story_list_widget.dart';
import '../../provider/auth_provider.dart';
import '../../provider/story_list_provider.dart';
import '../../static/story_list_result_state.dart';
import '../upload/add_story_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Story App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final authRead = context.read<AuthProvider>();
              final result = await authRead.logout();
              if (result) widget.onLogout();
            },
            icon: Icon(Icons.logout),
            tooltip: "Logout",
          ),
        ],
      ),
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
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        children: [
          SpeedDialChild(
            child: Icon(Icons.camera),
            label: "Camera",
            onTap: () => _onCameraView(),
          ),
          SpeedDialChild(
            child: Icon(Icons.photo),
            label: "Gallery",
            onTap: () => _onGalleryView(),
          ),
        ],
      ),
    );
  }

  _onGalleryView() async {
    final provider = context.read<HomeProvider>();

    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddStoryScreen()),
      );
    }
  }

  _onCameraView() async {
    final provider = context.read<HomeProvider>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddStoryScreen()),
      );
    }
  }
}
