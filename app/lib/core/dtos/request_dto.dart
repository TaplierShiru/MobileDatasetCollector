import 'package:json_annotation/json_annotation.dart';

import 'package:app/core/utils/status_code_enum.dart';

part 'request_dto.g.dart';

@JsonSerializable()
class RequestDto {
  late StatusCode statusCode;

  RequestDto(this.statusCode);

  factory RequestDto.fromJson(Map<String, dynamic> json) =>
      _$RequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RequestDtoToJson(this);
}
