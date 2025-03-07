import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../model/story/add_story_request.dart';
import '../../provider/add_story_provider.dart';

import '../../provider/home_provider.dart';

class AddStoryScreen extends StatefulWidget {
  final Function() toHomeScreen;

  const AddStoryScreen({super.key, required this.toHomeScreen});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Story'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              context.watch<HomeProvider>().imagePath == null
                  ? const Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.image, size: 100),
                  )
                  : _showImage(context),

              SizedBox.square(dimension: 16.0),

              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: 'Description'),
              ),

              SizedBox.square(dimension: 16.0),

              context.watch<AddStoryProvider>().isAddStoryLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                    onPressed: () async {
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      final XFile? imageFile = context.read<HomeProvider>().imageFile;

                      final AddStoryRequest addStory = AddStoryRequest(
                        description: descriptionController.text,
                        photo: imageFile!,
                        lat: null,
                        lon: null,
                      );

                      final addStoryRead = context.read<AddStoryProvider>();

                      final result = await addStoryRead.addStory(addStory);

                      if (result) {
                        widget.toHomeScreen();
                      } else {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(content: Text('upload gagal'))
                        );
                      }
                    },
                    child: const Text('Upload'),
                  ),

                  SizedBox.square(dimension: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showImage(BuildContext context) {
    final imagePath = context.read<HomeProvider>().imagePath;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child:
              kIsWeb
                  ? Image.network(
                    imagePath.toString(),
                    height: 500,
                    fit: BoxFit.contain,
                  )
                  : Image.file(
                    File(imagePath.toString()),
                    height: 500,
                    fit: BoxFit.contain,
                  ),
        ),
      ],
    );
  }
}
