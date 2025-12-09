// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.file,
    required this.delete,
  });

  final XFile file;
  final void Function(XFile) delete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Stack(
      children: [
        Image.file(
          (File(file.path)),
          width: double.infinity,
          height: 120,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 3,
          right: 3,
          child: InkWell(
            onTap: () => delete(file),
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ],
    ));
  }
}
