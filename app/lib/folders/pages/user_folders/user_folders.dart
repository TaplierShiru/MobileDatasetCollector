import 'package:flutter/material.dart';

class UserFoldersWidget extends StatefulWidget {
  final String folderId;

  const UserFoldersWidget({Key? key, required this.folderId}) : super(key: key);

  @override
  State<UserFoldersWidget> createState() => _UserFoldersWidgetState();
}

class _UserFoldersWidgetState extends State<UserFoldersWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Folder id=${widget.folderId}')),
    );
  }
}
