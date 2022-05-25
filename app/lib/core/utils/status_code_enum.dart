import 'package:json_annotation/json_annotation.dart';

enum StatusCode {
  @JsonValue(200)
  success,

  @JsonValue(401)
  unauthorized,

  @JsonValue(500)
  wrongEntity
}
