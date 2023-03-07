import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>?> pickImage() async {
    final images = await _picker.pickMultiImage();
    return images;
  }
}
