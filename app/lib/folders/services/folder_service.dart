import 'dart:convert';
import 'dart:io';

import 'package:app/folders/dtos/folder_dto.dart';
import 'package:app/folders/dtos/folder_element_dto.dart';
import 'package:app/user/dtos/user_dto.dart';
import 'package:app/utils/helpers/filter_parameters_dto.dart';

import '../../auth/services/auth_client.dart';
import '../../core/utils/status_code_enum.dart';
import '../../environment/environment.dart';
import '../../utils/exceptions/request_exception.dart';
import '../dtos/folder_element_update_dto.dart';
import '../dtos/folder_update_dto.dart';

class FolderService {
  final _imgUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1200px-Cat03.jpg';

  Future<List<FolderDto>> getFolders(
      AuthClient client, FilterParametersDto filterParametersDto) async {
    final response = await client.post(
      Uri.parse(Environment.appendToApiUrl(['folders', 'all'])),
      body: jsonEncode(filterParametersDto.toJson()),
    );

    if (response.statusCode ==
        StatusCodeExtended.getCodeForStatus(StatusCode.success)) {
      return [
        for (final element in jsonDecode(response.body))
          FolderDto.fromJson(element)
      ];
    }

    throw RequestException(statusCode: StatusCode.badRequest);
  }

  Future<FolderDto> getFolder(AuthClient client, String id) async {
    final response = await client.get(
      Uri.parse(Environment.appendToApiUrl(['folders', id])),
    );

    if (response.statusCode ==
        StatusCodeExtended.getCodeForStatus(StatusCode.success)) {
      return FolderDto.fromJson(jsonDecode(response.body));
    }

    throw RequestException(statusCode: StatusCode.badRequest);
  }

  Future<FolderDto> createFolder(
      AuthClient client, FolderUpdateDto folderDto) async {
    final response = await client.post(
      Uri.parse(Environment.appendToApiUrl(['folders'])),
      body: jsonEncode(folderDto.toJson()),
    );

    if (response.statusCode ==
        StatusCodeExtended.getCodeForStatus(StatusCode.created)) {
      return FolderDto.fromJson(jsonDecode(response.body));
    }

    throw RequestException(statusCode: StatusCode.badRequest);
  }

  Future<List<FolderElementDto>> getElementsFolder(AuthClient client,
      String parentId, FilterParametersDto filterParametersDto) async {
    final response = await client.post(
      Uri.parse(Environment.appendToApiUrl(
          ['folders', parentId, 'folder-elements', 'all'])),
      body: jsonEncode(filterParametersDto.toJson()),
    );

    if (response.statusCode ==
        StatusCodeExtended.getCodeForStatus(StatusCode.success)) {
      return [
        for (final element in jsonDecode(response.body))
          FolderElementDto.fromJson(element)
      ];
    }

    throw RequestException(statusCode: StatusCode.badRequest);
  }

  Future<FolderElementDto> createFolderElement(AuthClient client,
      String parentId, FolderElementUpdateDto folderElementUpdateDto) async {
    final response = await client.post(
      Uri.parse(
          Environment.appendToApiUrl(['folders', parentId, 'folder-elements'])),
      body: jsonEncode(folderElementUpdateDto.toJson()),
    );

    if (response.statusCode ==
        StatusCodeExtended.getCodeForStatus(StatusCode.created)) {
      return FolderElementDto.fromJson(jsonDecode(response.body));
    }

    throw RequestException(statusCode: StatusCode.badRequest);
  }

  Future<FolderElementDto> getElementFolder(String parentId, String id) async {
    throw RequestException(statusCode: StatusCode.badRequest);
  }

  Future<List<String>> getLabelsOfFolder(String id) async {
    throw RequestException(statusCode: StatusCode.badRequest);
  }

  Future<void> deleteFolderElement(
      String parentId, FolderElementDto folderElementDto) async {
    throw RequestException(statusCode: StatusCode.badRequest);
  }
}
