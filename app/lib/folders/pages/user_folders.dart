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
  var _isDeleteMode = false;
  var _isInProgress = false;
  final Set<int> _selectedIndexToDelete = {};

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
        actions: appBarActions(),
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
      floatingActionButton: getFloatingActionButton(),
    );
  }

  List<Widget> appBarActions() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: _changeDeleteModeStateActionButton(),
      ),
    ];
  }

  Widget getSliverGrid(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return GestureDetector(
          onTap: () {
            if (_isInProgress) {
              return;
            }

            if (_isDeleteMode) {
              setState(() {
                if (_selectedIndexToDelete.contains(index)) {
                  _selectedIndexToDelete.remove(index);
                } else {
                  _selectedIndexToDelete.add(index);
                }
              });
              return;
            }
            Navigator.pushNamed(
              context,
              AppRoute.routes[RouteEnum.singleFolderElementRoute]!,
              arguments: {
                'folderElementDto': _folderElements[index],
                'folderId': widget.folderId,
              },
            );
          },
          child: Container(
            height: 300,
            alignment: Alignment.center,
            color: Colors.blue,
            child: _columnSingleElementView(index),
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

  Widget _columnSingleElementView(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedOpacity(
          opacity: _isDeleteMode ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 400),
          child: Align(
            alignment: Alignment.topRight,
            child: _selectedIndexToDelete.contains(index)
                ? const Icon(Icons.check_box)
                : const Icon(Icons.check_box_outline_blank),
          ),
        ),
        SizedBox(
          height: 150,
          child: Hero(
            tag: 'to-single-element-index-${_folderElements[index].id}',
            child: Image.network(_folderElements[index].imageUrl,
                fit: BoxFit.contain),
          ),
        ),
        Text(_folderElements[index].name),
        Text(_folderElements[index].label),
        Text(_folderElements[index].id),
      ],
    );
  }

  Widget getFloatingActionButton() {
    if (_isInProgress) {
      return const CircularProgressIndicator(
        backgroundColor: Colors.white,
      );
    }

    if (_isDeleteMode) {
      return _deleteSelectedFloatingActionButton();
    }

    return _addFloatingActionButton();
  }

  Widget _deleteSelectedFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        if (_isInProgress) {
          return;
        }
        setState(() {
          _isInProgress = true;
        });
        final folderViewModel = context.read<FoldersViewModel>();
        for (var index in _selectedIndexToDelete) {
          await folderViewModel.deleteFolderElement(
            widget.folderId,
            _folderElements[index],
          );
        }
        await _refresh();
        setState(() {
          _isInProgress = false;
        });
      },
      backgroundColor: Colors.blue,
      child: const Icon(Icons.delete),
    );
  }

  Widget _addFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        if (_isInProgress) {
          return;
        }
        // Go to folder creation page
        Navigator.pushNamed(
          context,
          AppRoute.routes[RouteEnum.createFolderElementRoute]!,
          arguments: widget.folderId,
        );
      },
      backgroundColor: Colors.blue,
      child: const Icon(Icons.add),
    );
  }

  Widget _changeDeleteModeStateActionButton() {
    return IconButton(
      onPressed: () {
        if (_isInProgress) {
          return;
        }
        setState(() {
          _isDeleteMode = !_isDeleteMode;
          if (!_isDeleteMode) {
            _selectedIndexToDelete.clear();
          }
        });
      },
      icon: const Icon(Icons.delete_sweep),
    );
  }

  Future<void> _refresh() async {
    final filterDto = FilterParametersDto(_search);
    final folderElements = await context
        .read<FoldersViewModel>()
        .getElementsFolder(widget.folderId, filterDto);
    setState(() {
      _selectedIndexToDelete.clear();
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
