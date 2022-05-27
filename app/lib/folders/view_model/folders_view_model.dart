import 'package:flutter/foundation.dart';

import '../../utils/helpers/filter_parameters_dto.dart';
import '../dtos/folder_dto.dart';
import '../dtos/folder_element_dto.dart';
import '../services/folder_service.dart';

class FoldersViewModel extends ChangeNotifier {
  final _folderService = FolderService();

  Future<List<FolderDto>> getFolders(FilterParametersDto filterParametersDto) {
    return _folderService.getFolders(filterParametersDto);
  }

  Future<List<FolderElementDto>> getElementFolder(
      FilterParametersDto filterParametersDto) {
    return _folderService.getElementFolder(filterParametersDto);
  }
}
