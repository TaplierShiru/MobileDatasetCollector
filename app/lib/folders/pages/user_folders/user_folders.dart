import 'package:flutter/material.dart';

class UserFoldersWidget extends StatefulWidget {
  const UserFoldersWidget({Key? key}) : super(key: key);

  @override
  State<UserFoldersWidget> createState() => _UserFoldersWidgetState();
}

class _UserFoldersWidgetState extends State<UserFoldersWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User folders')),
    );
  }
}
