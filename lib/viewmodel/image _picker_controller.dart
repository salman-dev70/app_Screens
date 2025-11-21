import 'dart:io';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  Rx<File?> coverImage = Rx<File?>(null);
  RxList<File> galleryImages = <File>[].obs;

  // Cover image pick method
  Future<void> pickCoverImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        coverImage.value = File(pickedFile.path);
      }
    } catch (e) {
      print('Error picking cover image: $e');
    }
  }

  // Small image pick method - YEH CHANGE KARNA HAI
  Future<void> pickSmallImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        final newImage = File(pickedFile.path);

        // AGAR PEHLI IMAGE HAI TO COVER BANA DO
        if (coverImage.value == null && galleryImages.isEmpty) {
          coverImage.value = newImage;
        }
        // NAHI TO SMALL IMAGES MEIN ADD KARO
        else if (galleryImages.length < 3) {
          galleryImages.add(newImage);
        }
      }
    } catch (e) {
      print('Error picking small image: $e');
    }
  }

  // Remove small image
  void removeSmallImage(int index) {
    if (index >= 0 && index < galleryImages.length) {
      galleryImages.removeAt(index);
    }
  }
}
