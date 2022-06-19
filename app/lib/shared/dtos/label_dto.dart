import 'package:app/core/dtos/base_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'label_dto.g.dart';

@JsonSerializable()
class LabelDto extends BaseDto {
  @JsonKey(required: true)
  late String name;

  LabelDto(id, this.name) : super(id);

  factory LabelDto.fromJson(Map<String, dynamic> json) =>
      _$LabelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LabelDtoToJson(this);
}
