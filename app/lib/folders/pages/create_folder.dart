import 'package:app/folders/dtos/folder_dto.dart';
import 'package:app/folders/view_model/folders_view_model.dart';
import 'package:app/utils/exceptions/request_exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/dtos/label_update_dto.dart';
import '../../utils/validators/required_validator.dart';
import '../../utils/validators/type_helpers.dart';
import '../../utils/widgets/async_button.dart';
import '../dtos/folder_update_dto.dart';

class CreateFolderWidget extends StatefulWidget {
  const CreateFolderWidget({Key? key}) : super(key: key);

  @override
  State<CreateFolderWidget> createState() => _CreateFolderWidgetState();
}

class _CreateFolderWidgetState extends State<CreateFolderWidget> {
  final _nameFolderControl = TextEditingController();
  final _labelControl = TextEditingController();
  final _labels = <String>[];

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameFolderControl.dispose();
    _labelControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new folder'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              textFormField(
                'Name',
                'Enter name of the folder',
                _nameFolderControl,
                requiredValidator,
              ),
              textFormLabelField(),
              getLabelsWidget()
            ],
          ),
        ),
      ),
      floatingActionButton: saveButton(),
    );
  }

  Widget getLabelsWidget() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Labels',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 500,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_labels[index]),
                trailing: IconButton(
                  onPressed: () {
                    _deleteLabel(index);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
            itemCount: _labels.length,
          ),
        ),
      ],
    );
  }

  Widget textFormField(String labelText, String hintText,
      TextEditingController controller, ValidatorCall validator,
      {Widget? suffixIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
          suffixIcon: suffixIcon,
        ),
        validator: validator,
      ),
    );
  }

  Widget textFormLabelField() {
    return textFormField(
      'Labels',
      'Enter label',
      _labelControl,
      (String? value) => null,
      suffixIcon: IconButton(
        onPressed: () {
          _updateLabels();
          _labelControl.clear();
        },
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget saveButton() {
    return AsyncButton(
      onAsyncCall: () async {
        if (_formKey.currentState!.validate()) {
          final createFolderDto = FolderUpdateDto(
            _nameFolderControl.text,
            _labels.map((e) => LabelUpdateDto(e)).toList(),
          );
          try {
            await context
                .read<FoldersViewModel>()
                .createFolder(createFolderDto);

            if (!mounted) return false;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Successfully saved'),
            ));
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
            return true;
          } on RequestException {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Something went wrong...'),
            ));
          }
          return false;
        }

        if (!mounted) return false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to save'),
        ));
        return false;
      },
      initButtonChild: const Icon(Icons.save),
      isFloatingButton: true,
    );
  }

  void _updateLabels() {
    setState(() {
      _labels.add(_labelControl.value.text);
    });
  }

  void _deleteLabel(int index) {
    setState(() {
      _labels.removeAt(index);
    });
  }
}
