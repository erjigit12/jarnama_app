// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageStorage {
  final storageRef = FirebaseStorage.instance.ref();
  Future<List<String>?> uploadImage(List<XFile> image) async {
    List<String> urls = [];
    if (image.isNotEmpty) {
      for (var i in image) {
        try {
          final mountainsRef =
              storageRef.child("images/${DateTime.now().year}/${i.name}");
          File file = File(i.path);
          final uploadTask = await mountainsRef.putFile(file);
          final url = await uploadTask.ref.getDownloadURL();
          urls.add(url);
        } catch (error) {
          log(error.toString() as num);
        }
      }
      return urls;
    } else {
      return null;
    }
  }
}
