import 'package:json_annotation/json_annotation.dart';

enum StatusCode {
  @JsonValue(200)
  success,

  @JsonValue(201)
  created,

  @JsonValue(401)
  unauthorized,

  @JsonValue(403)
  badRequest,

  @JsonValue(500)
  wrongEntity
}

extension StatusCodeExtended on StatusCode {
  static final codeToNumber = {
    StatusCode.success: 200,
    StatusCode.created: 201,
    StatusCode.unauthorized: 401,
    StatusCode.badRequest: 403,
    StatusCode.wrongEntity: 500
  };

  static int getCodeForStatus(StatusCode statusCode) {
    return StatusCodeExtended.codeToNumber[statusCode]!;
  }
}
