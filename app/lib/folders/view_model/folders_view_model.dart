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

  Future<List<FolderElementDto>> getElementsFolder(
      String id, FilterParametersDto filterParametersDto) {
    return _folderService.getElementsFolder(id, filterParametersDto);
  }

  Future<FolderElementDto> getElementFolder(String parentId, String id) {
    return _folderService.getElementFolder(parentId, id);
  }

  Future<void> createFolder(FolderDto folderDto) async {
    await _folderService.createFolder(folderDto);
    notifyListeners();
  }

  Future<List<String>> getLabelsOfFolder(String id) async {
    return _folderService.getLabelsOfFolder(id);
  }
}
