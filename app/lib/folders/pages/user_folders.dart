import 'package:app/folders/dtos/folder_element_dto.dart';
import 'package:app/utils/helpers/filter_parameters_dto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/routes.dart';
import '../view_model/folders_view_model.dart';

class UserFoldersWidget extends StatefulWidget {
  final String folderId;

  const UserFoldersWidget({Key? key, required this.folderId}) : super(key: key);

  @override
  State<UserFoldersWidget> createState() => _UserFoldersWidgetState();
}

class _UserFoldersWidgetState extends State<UserFoldersWidget> {
  final _boxHeight = 300;
  final _boxWidth = 250;
  var _search = '';

  late List<FolderElementDto> _folderElements;
  late Future<void> _initData;

  @override
  void initState() {
    super.initState();
    _initData = _initFolders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Folder id=${widget.folderId}'),
      ),
      body: FutureBuilder(
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
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      getSliverGrid(context),
                    ],
                  ),
                );
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Go to folder creation page
          Navigator.pushNamed(
            context,
            AppRoute.routes[RouteEnum.createFolderElementRoute]!,
            arguments: widget.folderId,
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget getSliverGrid(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        final image =
            Image.network(_folderElements[index].imageUrl, fit: BoxFit.contain);
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
                context, AppRoute.routes[RouteEnum.singleFolderElementRoute]!,
                arguments: {
                  'folderElementDto': _folderElements[index],
                  'folderId': widget.folderId
                });
          },
          child: Container(
            height: 300,
            alignment: Alignment.center,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 150,
                  child: Hero(
                    tag: 'to-single-element-index-${_folderElements[index].id}',
                    child: image,
                  ),
                ),
                Text(_folderElements[index].name),
                Text(_folderElements[index].label),
                Text(_folderElements[index].id),
              ],
            ),
          ),
        );
      }, childCount: _folderElements.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: (_boxWidth / _boxHeight),
      ),
    );
  }

  Future<void> _refresh() async {
    final filterDto = FilterParametersDto(_search);
    final folderElements = await context
        .read<FoldersViewModel>()
        .getElementsFolder(widget.folderId, filterDto);

    setState(() {
      _folderElements = folderElements;
    });
    return Future<void>.value();
  }

  Future<void> _initFolders() async {
    final filterDto = FilterParametersDto(_search);
    final folderElements = await context
        .read<FoldersViewModel>()
        .getElementsFolder(widget.folderId, filterDto);
    _folderElements = folderElements;
  }
}
