import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';

class CreateFolderElementController {
  List<String> labels = [];
  List<XFile> imageFileList = [];
  List<TextEditingController> nameControllerList = [];
  List<String> labelDropdownValueList = [];

  void addImageFileToImageFileFile(XFile? value) {
    if (value != null) {
      imageFileList.add(value);
      labelDropdownValueList.add(labels[0]);
      nameControllerList.add(TextEditingController());
    }
  }

  void removeImageFile(int index) {
    imageFileList.removeAt(index);
    labelDropdownValueList.removeAt(index);
    nameControllerList.removeAt(index);
  }

  void printSize() {
    print(imageFileList.length);
  }
}
