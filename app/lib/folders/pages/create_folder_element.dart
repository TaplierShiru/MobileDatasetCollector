import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/validators/required_validator.dart';
import '../../utils/validators/type_helpers.dart';
import '../view_model/folders_view_model.dart';

class CreateFolderElementWidget extends StatefulWidget {
  final String folderId;
  const CreateFolderElementWidget({Key? key, required this.folderId})
      : super(key: key);

  @override
  State<CreateFolderElementWidget> createState() =>
      _CreateFolderElementWidgetState();
}

class _CreateFolderElementWidgetState extends State<CreateFolderElementWidget> {
  final _nameElementControl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _selectedLabel;
  late List<String> _labels;
  late Future<void> _initData;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _initData = _initLabels();
  }

  @override
  void dispose() {
    _nameElementControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new folder element'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            textFormField('Name', 'Enter name of the folder element',
                _nameElementControl, requiredValidator),
            SingleChildScrollView(
              child: Container(
                child: selectLabelWidget(),
              ),
            ),
          ],
        ),
      ),
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

  Widget selectLabelWidget() {
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
              return getSelectLabelWidget();
            }
        }
      },
    );
  }

  Widget getSelectLabelWidget() {
    return ExpansionPanelList(
      expansionCallback: (i, isEx) {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (context, isExpanded) {
            return Center(
              child: _selectedLabel != null
                  ? Text('Labels. Selected: $_selectedLabel')
                  : const Text('Labels. Select one'),
            );
          },
          isExpanded: _isExpanded,
          body: SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: _labels.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedLabel = _labels[index];
                    });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_labels[index]),
                        _selectedLabel == _labels[index]
                            ? const Icon(Icons.done)
                            : const Icon(Icons.circle)
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _initLabels() async {
    final labels = await context
        .read<FoldersViewModel>()
        .getLabelsOfFolder(widget.folderId);
    _labels = labels;
  }
}
