import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jarnama/services/image_picker_service.dart';

class ImageContainer extends StatefulWidget {
  const ImageContainer({
    super.key,
    required this.images,
  });
  final List<XFile> images;

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  final service = ImagePickerService();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 200,
        child: IconButton(
          onPressed: () {
            service.pickImage();
          },
          icon: const Icon(
            Icons.camera_enhance,
            size: 30,
          ),
        ),
      ),
    );
  }
}
