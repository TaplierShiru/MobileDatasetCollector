import 'dart:math';

import 'package:app/shared/dtos/label_dto.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';

class CreateFolderElementController {
  List<LabelDto> labels = [];
  List<XFile> imageFileList = [];
  List<TextEditingController> nameControllerList = [];
  List<LabelDto> labelDropdownValueList = [];

  int get length {
    return min(nameControllerList.length,
        min(labelDropdownValueList.length, imageFileList.length));
  }

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
