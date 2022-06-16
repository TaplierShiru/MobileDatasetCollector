import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../dtos/create_user_dto.dart';
import '../../core/utils/status_code_enum.dart';
import '../../environment/environment.dart';
import '../../utils/exceptions/request_exception.dart';
import '../dtos/token_dto.dart';

class AuthService {
  Future<TokenDto> login(
      http.Client client, String email, String password) async {
    final response = await client.post(
      Uri.parse(Environment.appendToApiUrl(['auth', 'token'])),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );
    // status code -- created
    if (response.statusCode ==
        StatusCodeExtended.getCodeForStatus(StatusCode.success)) {
      return TokenDto.fromJson(jsonDecode(response.body));
    }

    throw RequestException(statusCode: StatusCode.unauthorized);
  }

  Future<bool> register(http.Client client, CreateUserDto createUserDto) async {
    final response = await client.post(
      Uri.parse(Environment.appendToApiUrl(['auth', 'register'])),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
      body: jsonEncode(createUserDto.toJson()),
    );
    // status code -- created
    if (response.statusCode ==
        StatusCodeExtended.getCodeForStatus(StatusCode.created)) {
      return true;
    }

    throw RequestException(statusCode: StatusCode.badRequest);
  }
}
