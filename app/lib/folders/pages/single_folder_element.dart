import 'package:app/folders/dtos/folder_element_dto.dart';
import 'package:app/folders/view_model/folders_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    _folderElementDto = widget.folderElementDto;
  }

  @override
  Widget build(BuildContext context) {
    final image =
        Image.network(_folderElementDto.imageUrl, fit: BoxFit.contain);
    return Scaffold(
      appBar:
          AppBar(title: Text('Folder element ${widget.folderElementDto.id}')),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              height: 350,
              child: Hero(
                tag: 'to-single-element-index-${widget.folderElementDto.id}',
                child: image,
              ),
            ),
          ),
          Text(widget.folderElementDto.name),
          Text(widget.folderElementDto.label),
          Text(widget.folderElementDto.id),
        ],
      ),
    );
  }

  Future<void> _refresh() async {
    final folderElement = await context
        .read<FoldersViewModel>()
        .getElementFolder(widget.folderId, widget.folderElementDto.id);
    setState(() {
      _folderElementDto = folderElement;
    });
  }
}
