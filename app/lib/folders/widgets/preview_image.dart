import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PreviewImageWidget extends StatelessWidget {
  final XFile imageFile;
  final String tag;
  const PreviewImageWidget(
      {Key? key, required this.imageFile, this.tag = 'singleImagePreview'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: tag,
            child: kIsWeb
                ? Image.network(imageFile.path)
                : Image.file(File(imageFile.path)),
          ),
        ),
      ),
    );
  }
}
