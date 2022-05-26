import 'package:flutter/widgets.dart';

class FoldersWidget extends StatefulWidget {
  const FoldersWidget({Key? key}) : super(key: key);

  @override
  State<FoldersWidget> createState() => _FoldersWidgetState();
}

class _FoldersWidgetState extends State<FoldersWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text('Folders');
  }
}
