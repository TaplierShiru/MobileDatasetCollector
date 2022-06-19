import 'package:json_annotation/json_annotation.dart';

part 'label_update_dto.g.dart';

@JsonSerializable()
class LabelUpdateDto {
  @JsonKey(required: true)
  late String name;

  LabelUpdateDto(this.name);

  factory LabelUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$LabelUpdateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LabelUpdateDtoToJson(this);
}
