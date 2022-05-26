import 'package:app/core/dtos/base_dto.dart';
import 'package:app/user/dtos/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'folder_element_dto.g.dart';

@JsonSerializable()
class FolderElementDto extends BaseDto {
  @JsonKey(required: true)
  late String name;

  @JsonKey(required: true)
  late String label;

  @JsonKey(required: true)
  late String imageUrl;

  @JsonKey(required: true)
  late DateTime dateUploaded;

  @JsonKey(required: true)
  late DateTime dateChanged;

  @JsonKey(required: true)
  late UserDto lastUserChange;

  FolderElementDto(String id, this.name, this.label, this.imageUrl,
      this.dateUploaded, this.dateChanged, this.lastUserChange)
      : super(id);

  factory FolderElementDto.fromJson(Map<String, dynamic> json) =>
      _$FolderElementDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FolderElementDtoToJson(this);
}
