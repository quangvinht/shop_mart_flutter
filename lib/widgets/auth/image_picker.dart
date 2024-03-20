import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_mart/services/app_function.dart';

class ImagePickerField extends StatefulWidget {
  const ImagePickerField({super.key, required this.onPickImage});

  final void Function(XFile image) onPickImage;

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  XFile? _imagePicked;

  Future<void> pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    await MyAppFunctions.imagePickerDialog(
        context: context,
        onChooseCamera: () async {
          final XFile? image =
              await picker.pickImage(source: ImageSource.camera);
          if (image != null) {
            setState(() {
              _imagePicked = image;
            });
            widget.onPickImage(image);
          }
        },
        onChooseGallery: () async {
          final XFile? image =
              await picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            setState(() {
              _imagePicked = image;
            });
            widget.onPickImage(image);
          }
        },
        onRemoveImage: () {
          setState(() {
            _imagePicked = null;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16),
              ),
              child: _imagePicked == null
                  ? const Icon(null)
                  : Image.file(
                      File(_imagePicked!.path),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Material(
            borderRadius: BorderRadius.circular(16),
            color: Colors.lightBlue,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () async {
                await pickImage(context);
              },
              highlightColor: Colors.red,
              child: IconButton(
                onPressed: () async {
                  await pickImage(context);
                },
                color: Colors.white,
                icon: const Icon(
                  IconlyLight.image2,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
