import 'package:app/core/routes/routes.dart';
import 'package:app/folders/view_model/folders_view_model.dart';
import 'package:app/utils/helpers/filter_parameters_dto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dtos/folder_dto.dart';

class FoldersWidget extends StatefulWidget {
  const FoldersWidget({Key? key}) : super(key: key);

  @override
  State<FoldersWidget> createState() => _FoldersWidgetState();
}

class _FoldersWidgetState extends State<FoldersWidget> {
  final String _search = '';

  @override
  Widget build(BuildContext context) {
    final filterParametersDto = FilterParametersDto(_search);
    final folders =
        context.watch<FoldersViewModel>().getFolders(filterParametersDto);

    return FutureBuilder(
      future: folders,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return listFolders(snapshot.data as List<FolderDto>);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget listFolders(List<FolderDto> folders) {
    return ListView.builder(
      itemCount: folders.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(folders[index].folderName),
          subtitle: Text('Number of records: ${folders[index].numberRecords}'),
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoute.routes[RouteEnum.singleFolderRoute]!,
              arguments: folders[index].id,
            );
          },
        );
      },
    );
  }
}
