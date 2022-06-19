import 'dart:convert';
import 'dart:io';

import 'package:app/folders/dtos/folder_element_dto.dart';
import 'package:app/folders/view_model/folders_view_model.dart';
import 'package:app/shared/dtos/label_dto.dart';
import 'package:app/utils/validators/required_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../utils/validators/type_helpers.dart';
import '../../utils/widgets/text_form_field.dart';
import '../dtos/folder_element_update_dto.dart';
import '../widgets/preview_image.dart';

class SingleFolderElementWidget extends StatefulWidget {
  final FolderElementDto folderElementDto;
  final String folderId;

  const SingleFolderElementWidget(
      {Key? key, required this.folderId, required this.folderElementDto})
      : super(key: key);

  @override
  State<SingleFolderElementWidget> createState() =>
      _SingleFolderElementWidgetState();
}

class _SingleFolderElementWidgetState extends State<SingleFolderElementWidget> {
  late FolderElementDto _folderElementDto;
  late LabelDto _selectedLabel;
  XFile? _newImageFile;
  dynamic _pickImageError;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  final _nameController = TextEditingController();

  late List<LabelDto> _labels;
  late Future<void> _initData;

  @override
  void initState() {
    super.initState();
    _selectedLabel = widget.folderElementDto.label;
    _nameController.text = widget.folderElementDto.name;
    _folderElementDto = widget.folderElementDto;
    _initData = _initLabels();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Folder element ${_folderElementDto.id}')),
      body: _folderElementInfo(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _floatingGalleryButton(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _floatingUploadImageButton(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _floatingUpdateButton(),
          ),
        ],
      ),
    );
  }

  Widget _folderElementInfo() {
    return Column(
      children: [
        Center(
          child: _imagePreview(),
        ),
        TextFormFieldWidget(
          controller: _nameController,
          labelText: 'Name',
          hintText: 'Name of the image',
        ),
        _initDropdownLabelsButton(),
        Text(_folderElementDto.id),
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

  Widget _imagePreview() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_pickImageError == null) {
      Image image;
      if (_newImageFile != null) {
        image = kIsWeb
            ? Image.network(_newImageFile!.path)
            : Image.file(File(_newImageFile!.path));
      } else {
        image = Image.network(_folderElementDto.imageUrl);
      }
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PreviewImageWidget(
                  imageFile: null,
                  imageWidget: image,
                  tag: 'to-single-element-index-${_folderElementDto.id}',
                );
              },
            ),
          );
        },
        child: SizedBox(
          height: 300,
          child: Hero(
            tag: 'to-single-element-index-${_folderElementDto.id}',
            child: Semantics(
              label: 'image_picker_example_picked_image',
              child: image,
            ),
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

  Widget _floatingGalleryButton() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        _onImageButtonPressed(
          ImageSource.gallery,
          context: context,
        );
      },
      child: const Icon(Icons.photo_library),
    );
  }

  Widget _floatingUploadImageButton() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        _onImageButtonPressed(ImageSource.camera, context: context);
      },
      child: const Icon(Icons.camera_alt),
    );
  }

  Widget _floatingUpdateButton() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () async {
        final imageFile = _newImageFile != null
            ? base64Encode(
                await _newImageFile!.readAsBytes(),
              )
            : null;
        final updateDto = FolderElementUpdateDto(
            _nameController.text, _selectedLabel, imageFile);
        await _refresh();
      },
      child: const Icon(Icons.update),
    );
  }

  Widget _initDropdownLabelsButton() {
    return FutureBuilder(
      future: _initData,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            {
              return const Center(child: CircularProgressIndicator());
            }
          case ConnectionState.done:
            {
              return _dropdownLabelsButton();
            }
        }
      },
    );
  }

  Widget _dropdownLabelsButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: DropdownButton<LabelDto>(
        value: _selectedLabel,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        isExpanded: true,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepOrangeAccent,
        ),
        onChanged: (LabelDto? newValue) {
          setState(() {
            _selectedLabel = newValue!;
          });
        },
        items: _labels.map<DropdownMenuItem<LabelDto>>((LabelDto value) {
          return DropdownMenuItem(value: value, child: Text(value.name));
        }).toList(),
      ),
    );
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
        );
        setState(() {
          _newImageFile = pickedFile;
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
        _newImageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Future<void> _refresh() async {
    final folderElement = await context
        .read<FoldersViewModel>()
        .getElementFolder(widget.folderId, _folderElementDto.id);
    setState(() {
      _folderElementDto = folderElement;
    });
  }

  Future<void> _initLabels() async {
    final folderDto =
        await context.read<FoldersViewModel>().getFolder(widget.folderId);
    _labels = folderDto.labels;
  }
}
