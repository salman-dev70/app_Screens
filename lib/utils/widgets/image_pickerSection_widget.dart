import 'dart:io';
import 'package:app_screens/utils/string_resources.dart';
import 'package:app_screens/viewmodel/image%20_picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerSection extends StatelessWidget {
  ImagePickerSection({super.key});

  final controller = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            StringResources.addImage,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 20),
        // COVER IMAGE CONTAINER
        GestureDetector(
          onTap: () {
            if (controller.coverImage.value == null) {
              _showImagePickerBottomSheet(context, isCover: true);
            }
          },
          child: Obx(
            () => Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color.fromARGB(255, 167, 167, 167),
                ),
                image:
                    controller.coverImage.value != null
                        ? DecorationImage(
                          image: FileImage(controller.coverImage.value!),
                          fit: BoxFit.cover,
                        )
                        : null,
              ),
              child:
                  controller.coverImage.value == null
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8),
                          Text(
                            StringResources.addMeetupCoverImage,
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            StringResources.imageDimensions,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                      : Stack(
                        children: [
                          Positioned(
                            right: 8,
                            top: 8,
                            child: GestureDetector(
                              onTap: () => controller.coverImage.value = null,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 14,
                                child: Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
            ),
          ),
        ),

        const SizedBox(height: 15),

        // ROW OF SMALL IMAGES
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(controller.galleryImages.length, (index) {
                final img = controller.galleryImages[index];
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: FileImage(img),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // REMOVE BUTTON
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () => controller.removeSmallImage(index),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),

              // ADD NEW IMAGE CONTAINER
              if (controller.galleryImages.length < 3)
                GestureDetector(
                  onTap: () => _showImagePickerBottomSheet(context),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 243, 243, 243),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: CircleAvatar(
                        radius: 13,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ],
    );
  }

  // Bottom Sheet to choose camera/gallery
  _showImagePickerBottomSheet(BuildContext context, {bool isCover = false}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(20),
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Camera
              GestureDetector(
                onTap: () {
                  if (isCover) {
                    controller.pickCoverImage(ImageSource.camera);
                  } else {
                    controller.pickSmallImage(ImageSource.camera);
                  }
                  Navigator.pop(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, size: 35),
                    SizedBox(height: 6),
                    Text("Camera"),
                  ],
                ),
              ),

              // Gallery
              GestureDetector(
                onTap: () {
                  if (isCover) {
                    controller.pickCoverImage(ImageSource.gallery);
                  } else {
                    controller.pickSmallImage(ImageSource.gallery);
                  }
                  Navigator.pop(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_library, size: 35),
                    SizedBox(height: 6),
                    Text("Gallery"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
