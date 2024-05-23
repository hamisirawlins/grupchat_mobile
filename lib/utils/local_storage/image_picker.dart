import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<Uint8List?> selectImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  } else {
    return null;
  }
}
