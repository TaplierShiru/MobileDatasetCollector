import 'package:json_annotation/json_annotation.dart';

part 'base_dto.g.dart';

@JsonSerializable()
class BaseDto {
  @JsonKey(required: true)
  late final String id;

  BaseDto(this.id);

  factory BaseDto.fromJson(Map<String, dynamic> json) =>
      _$BaseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BaseDtoToJson(this);
}
