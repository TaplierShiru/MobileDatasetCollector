import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../auth/services/auth_client.dart';
import '../../user/services/current_user_service.dart';
import '../../utils/helpers/filter_parameters_dto.dart';
import '../dtos/folder_dto.dart';
import '../dtos/folder_element_dto.dart';
import '../dtos/folder_element_update_dto.dart';
import '../dtos/folder_update_dto.dart';
import '../services/folder_service.dart';

class FoldersViewModel extends ChangeNotifier {
  final _folderService = FolderService();

  Future<List<FolderDto>> getFolders(FilterParametersDto filterParametersDto) {
    final CurrentUserService currentUserService = Get.find();
    currentUserService.updateCurrentUserDto(http.Client());
    return _folderService.getFolders(
      AuthClient(tokenDto: currentUserService.tokenDto),
      filterParametersDto,
    );
  }

  Future<FolderDto> getFolder(String id) {
    final CurrentUserService currentUserService = Get.find();
    currentUserService.updateCurrentUserDto(http.Client());
    return _folderService.getFolder(
      AuthClient(tokenDto: currentUserService.tokenDto),
      id,
    );
  }

  Future<void> createFolder(FolderUpdateDto folderDto) async {
    final CurrentUserService currentUserService = Get.find();
    currentUserService.updateCurrentUserDto(http.Client());
    await _folderService.createFolder(
      AuthClient(tokenDto: currentUserService.tokenDto),
      folderDto,
    );
    notifyListeners();
  }

  Future<List<FolderElementDto>> getElementsFolder(
      String id, FilterParametersDto filterParametersDto) {
    final CurrentUserService currentUserService = Get.find();
    currentUserService.updateCurrentUserDto(http.Client());
    return _folderService.getElementsFolder(
      AuthClient(tokenDto: currentUserService.tokenDto),
      id,
      filterParametersDto,
    );
  }

  Future<FolderElementDto> getElementFolder(String parentId, String id) {
    return _folderService.getElementFolder(parentId, id);
  }

  Future<List<String>> getLabelsOfFolder(String id) async {
    return _folderService.getLabelsOfFolder(id);
  }

  Future<void> createFolderElement(
      String parentId, FolderElementUpdateDto folderElementUpdateDto) async {
    final CurrentUserService currentUserService = Get.find();
    currentUserService.updateCurrentUserDto(http.Client());
    await _folderService.createFolderElement(
      AuthClient(tokenDto: currentUserService.tokenDto),
      parentId,
      folderElementUpdateDto,
    );
    notifyListeners();
  }

  Future<void> deleteFolderElement(
      String parentId, FolderElementDto folderElementDto) async {
    await _folderService.deleteFolderElement(parentId, folderElementDto);
    notifyListeners();
  }
}
