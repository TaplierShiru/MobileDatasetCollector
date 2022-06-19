import 'dart:convert';

import 'package:app/folders/utils/create_folder_element_controller.dart';
import 'package:app/user/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/validators/required_validator.dart';
import '../../utils/validators/type_helpers.dart';
import '../dtos/folder_element_update_dto.dart';
import '../view_model/folders_view_model.dart';
import '../widgets/upload_images_for_element.dart';

class CreateFolderElementWidget extends StatefulWidget {
  final String folderId;
  const CreateFolderElementWidget({Key? key, required this.folderId})
      : super(key: key);

  @override
  State<CreateFolderElementWidget> createState() =>
      _CreateFolderElementWidgetState();
}

class _CreateFolderElementWidgetState extends State<CreateFolderElementWidget> {
  final _formKey = GlobalKey<FormState>();

  var _isUploaded = false;
  late Future<void> _initData;

  final CreateFolderElementController _imageFilesHolder =
      CreateFolderElementController();

  @override
  void initState() {
    super.initState();
    _initData = _initLabels();
  }

  @override
  void dispose() {
    super.dispose();
    for (var element in _imageFilesHolder.nameControllerList) {
      element.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new folder element'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: _isUploaded
              ? const Center(child: CircularProgressIndicator())
              : addImagesWidget(),
        ),
      ),
      floatingActionButton: saveButton(),
    );
  }

  Widget addImagesWidget() {
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
              return UploadImagesForElementWidget(
                imageFilesHolder: _imageFilesHolder,
              );
            }
        }
      },
    );
  }

  Widget saveButton() {
    return FloatingActionButton(
      onPressed: () async {
        setState(() {
          _isUploaded = true;
        });
        for (var i = 0; i < _imageFilesHolder.length; i++) {
          final folderElementUpdate = FolderElementUpdateDto(
              _imageFilesHolder.nameControllerList[i].text,
              _imageFilesHolder.labelDropdownValueList[i],
              base64Encode(
                await _imageFilesHolder.imageFileList[i].readAsBytes(),
              ));

          if (!mounted) return;
          await context
              .read<FoldersViewModel>()
              .createFolderElement(widget.folderId, folderElementUpdate);
        }
        setState(() {
          _isUploaded = false;
        });

        if (!mounted) return;
        Navigator.pop(context);
      },
      child: const Icon(Icons.save),
    );
  }

  Future<void> _initLabels() async {
    final folderDto =
        await context.read<FoldersViewModel>().getFolder(widget.folderId);
    _imageFilesHolder.labels = folderDto.labels;
  }
}
