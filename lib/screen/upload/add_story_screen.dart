import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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

              OutlinedButton(
                onPressed: () {
                  widget.toHomeScreen();
                },
                child: Text("Upload"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _onCameraView() async {
  //   final provider = context.read<HomeProvider>();

  //   final isAndroid = defaultTargetPlatform == TargetPlatform.android;
  //   final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
  //   final isNotMobile = !(isAndroid || isiOS);
  //   if (isNotMobile) return;

  //   final ImagePicker picker = ImagePicker();

  //   final XFile? pickedFile = await picker.pickImage(
  //     source: ImageSource.camera,
  //   );

  //   if (pickedFile != null) {
  //     provider.setImageFile(pickedFile);
  //     provider.setImagePath(pickedFile.path);
  //   }
  // }

  // _onGalleryView() async {
  //   final provider = context.read<HomeProvider>();

  //   final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
  //   final isLinux = defaultTargetPlatform == TargetPlatform.linux;
  //   if (isMacOS || isLinux) return;

  //   final ImagePicker picker = ImagePicker();

  //   final XFile? pickedFile = await picker.pickImage(
  //     source: ImageSource.gallery,
  //   );

  //   if (pickedFile != null) {
  //     provider.setImageFile(pickedFile);
  //     provider.setImagePath(pickedFile.path);

  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const AddStoryScreen()),
  //     );
  //   }
  // }

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

        // Positioned(
        //   top: 10,
        //   right: 10,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.black54,
        //     child: IconButton(
        //       icon: const Icon(Icons.edit, color: Colors.white),
        //       onPressed: () => _showEditOptions(context),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // void _showEditOptions(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
  //     ),
  //     builder: (context) {
  //       return Wrap(
  //         children: [
  //           ListTile(
  //             leading: const Icon(Icons.camera_alt),
  //             title: const Text('Ambil Foto'),
  //             onTap: () {
  //               Navigator.pop(context);
  //               _onCameraView();
  //             },
  //           ),
  //           ListTile(
  //             leading: const Icon(Icons.photo_library),
  //             title: const Text('Pilih dari Galeri'),
  //             onTap: () {
  //               Navigator.pop(context);
  //               _onGalleryView();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
