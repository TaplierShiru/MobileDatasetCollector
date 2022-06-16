import 'dart:convert';
import 'dart:io';

import 'package:app/user/dtos/user_dto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../auth/dtos/token_dto.dart';
import '../../core/utils/status_code_enum.dart';
import '../../environment/environment.dart';
import '../../utils/exceptions/request_exception.dart';

class CurrentUserService extends ChangeNotifier {
  UserDto? currentUserDto;
  TokenDto? tokenDto;

  Future<void> updateCurrentUserDto(http.Client client) async {
    if (tokenDto == null) {
      throw RequestException(statusCode: StatusCode.unauthorized);
    }

    final response = await client
        .get(Uri.parse(Environment.appendToApiUrl(['auth', 'user'])), headers: {
      HttpHeaders.authorizationHeader: '${tokenDto!.type} ${tokenDto!.token}',
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });
    // status code -- created
    if (response.statusCode ==
        StatusCodeExtended.getCodeForStatus(StatusCode.success)) {
      currentUserDto = UserDto.fromJson(jsonDecode(response.body));
      return;
    }

    throw RequestException(statusCode: StatusCode.unauthorized);
  }
}
