//here we will write common standalone functions also called utilities functions
import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:path/path.dart" as p;

String getFileExtension(String filePath) {
  return p.extension(filePath);
}

String getFileName(String filePath) {
  return p.basename(filePath);
}

void debugLog(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}

Future<List<File>> pickImagesFromGallery(context) async {
  final picker = ImagePicker(); // Instance of Image picker
  List<File> selectedImages = [];
  final pickedFile = await picker.pickMultiImage(
// imageQuality: 100, // To set quality of images
// maxHeight: 300, // To set maxheight of images that you want in your app
// maxWidth: 300
      ); // To set maxheight of images that you want in your app
  List<XFile> xfilePick = pickedFile;

  if (xfilePick.isNotEmpty) {
    for (var i = 0; i < xfilePick.length; i++) {
      selectedImages.add(File(xfilePick[i].path));
    }
    return selectedImages;
  } else {
// If no image is selected it will show a
// snackbar saying nothing is selected
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1), content: Text('Nothing selected')));

    return selectedImages;
  }
}

extension SpaceXY on int {
  SizedBox get spaceX => SizedBox(
        width: toDouble(),
      );

  SizedBox get spaceY => SizedBox(
        height: toDouble(),
      );
}
