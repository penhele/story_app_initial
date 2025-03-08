import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app_initial/provider/story_list_provider.dart';
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
    final homeProvider = context.watch<HomeProvider>();
    final addStoryProvider = context.watch<AddStoryProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Story'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              homeProvider.imagePath == null
                  ? const Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.image, size: 100),
                  )
                  : _showImage(context),

              const SizedBox(height: 16.0),

              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: 'Description'),
              ),

              const SizedBox(height: 16.0),

              addStoryProvider.isAddStoryLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                    onPressed: () async {
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      final XFile? imageFile = homeProvider.imageFile;

                      if (imageFile == null) {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                            content: Text('Pilih gambar terlebih dahulu!'),
                          ),
                        );
                        return;
                      }

                      // Cek ukuran file
                      File file = File(imageFile.path);
                      int fileSize = await file.length();
                      if (fileSize > 1024 * 1024) {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                            content: Text('File terlalu besar! Maksimum 1MB.'),
                          ),
                        );
                        return;
                      }

                      if (descriptionController.text.trim().isEmpty) {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                            content: Text('Deskripsi tidak boleh kosong!'),
                          ),
                        );
                        return;
                      }

                      final AddStoryRequest addStory = AddStoryRequest(
                        description: descriptionController.text,
                        photo: imageFile,
                        lat: null,
                        lon: null,
                      );

                      try {
                        final result = await context
                            .read<AddStoryProvider>()
                            .addStory(addStory);

                        if (result) {
                          context.read<StoryListProvider>().fetchStoryList();
                          widget.toHomeScreen();
                        } else {
                          scaffoldMessenger.showSnackBar(
                            const SnackBar(content: Text('Upload gagal!')),
                          );
                        }
                      } catch (e) {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(content: Text('Terjadi kesalahan: $e')),
                        );
                      }
                    },
                    child: const Text('Upload'),
                  ),

              const SizedBox(height: 16.0),
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
