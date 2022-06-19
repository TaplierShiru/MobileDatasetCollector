import 'dart:io';

import 'package:app/auth/dtos/token_dto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../core/utils/status_code_enum.dart';
import '../../utils/exceptions/request_exception.dart';

class AuthClient extends BaseClient {
  final TokenDto? tokenDto;
  AuthClient({Key? key, required this.tokenDto}) : super();

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    if (tokenDto == null) {
      throw RequestException(statusCode: StatusCode.unauthorized);
    }
    request.headers.addAll({
      HttpHeaders.authorizationHeader: '${tokenDto!.type} ${tokenDto!.token}',
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });

    return request.send();
  }
}
