import 'dart:io';

import 'package:app/folders/widgets/preview_image.dart';
import 'package:app/utils/validators/required_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/validators/type_helpers.dart';
import '../../utils/widgets/text_form_field.dart';
import '../utils/create_folder_element_controller.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class UploadImagesForElementWidget extends StatefulWidget {
  final CreateFolderElementController imageFilesHolder;
  const UploadImagesForElementWidget({Key? key, required this.imageFilesHolder})
      : super(key: key);

  @override
  State<UploadImagesForElementWidget> createState() =>
      _UploadImagesForElementWidgetState();
}

class _UploadImagesForElementWidgetState
    extends State<UploadImagesForElementWidget> {
  dynamic _pickImageError;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
              child: const Icon(Icons.photo),
            ),
            ElevatedButton(
              onPressed: () {
                _onImageButtonPressed(
                  ImageSource.gallery,
                  context: context,
                  isMultiImage: true,
                );
              },
              child: const Icon(Icons.photo_library),
            ),
            ElevatedButton(
              onPressed: () {
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              child: const Icon(Icons.camera_alt),
            ),
          ],
        ),
        Center(
          child: FutureBuilder<void>(
            future: retrieveLostData(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Text(
                    'You have not yet picked an image.',
                    textAlign: TextAlign.center,
                  );
                case ConnectionState.done:
                  return _previewImages();
                default:
                  if (snapshot.hasError) {
                    return Text(
                      'Pick image/video error: ${snapshot.error}}',
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return const Text(
                      'You have not yet picked an image.',
                      textAlign: TextAlign.center,
                    );
                  }
              }
            },
          ),
        ),
      ],
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (widget.imageFilesHolder.imageFileList != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: SizedBox(
          height: 500,
          child: ListView.builder(
            key: UniqueKey(),
            itemBuilder: _singleImage,
            itemCount: widget.imageFilesHolder.imageFileList!.length,
          ),
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _singleImage(BuildContext context, int index) {
    // Why network for web?
    // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PreviewImageWidget(
                        imageFile:
                            widget.imageFilesHolder.imageFileList![index],
                        tag: 'singleImage-created-$index');
                  },
                ),
              );
            },
            child: Hero(
              tag: 'singleImage-created-$index',
              child: SizedBox(
                height: 200,
                child: Semantics(
                  label: 'image_picker_example_picked_image',
                  child: kIsWeb
                      ? Image.network(
                          widget.imageFilesHolder.imageFileList![index].path)
                      : Image.file(File(
                          widget.imageFilesHolder.imageFileList![index].path)),
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 200,
                child: TextFormFieldWidget(
                  controller: widget.imageFilesHolder.nameControllerList[index],
                  labelText: 'Name',
                  hintText: 'Name of the image',
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text('Label'),
                  ),
                  dropdownLabelsWithIndexButton(index),
                ],
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.imageFilesHolder.removeImageFile(index);
                  });
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget dropdownLabelsWithIndexButton(int index) {
    return DropdownButton<String>(
      value: widget.imageFilesHolder.labelDropdownValueList[index],
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepOrangeAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          widget.imageFilesHolder.labelDropdownValueList[index] = newValue!;
        });
      },
      items: widget.imageFilesHolder.labels
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
    );
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (isMultiImage) {
      try {
        final List<XFile>? pickedFileList = await _picker.pickMultiImage();
        setState(() {
          if (pickedFileList != null) {
            for (var element in pickedFileList) {
              widget.imageFilesHolder.addImageFileToImageFileFile(element);
            }
          }
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    } else {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
        );
        setState(() {
          widget.imageFilesHolder.addImageFileToImageFileFile(pickedFile);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          widget.imageFilesHolder.addImageFileToImageFileFile(response.file);
        } else {
          if (response.files != null) {
            for (var element in response.files!) {
              widget.imageFilesHolder.addImageFileToImageFileFile(element);
            }
          }
        }
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }
}
