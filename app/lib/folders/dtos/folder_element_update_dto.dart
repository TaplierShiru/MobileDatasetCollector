import 'package:app/user/dtos/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'folder_element_update_dto.g.dart';

@JsonSerializable()
class FolderElementUpdateDto {
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

  FolderElementUpdateDto(this.name, this.label, this.imageUrl,
      this.dateUploaded, this.dateChanged, this.lastUserChange);

  factory FolderElementUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$FolderElementUpdateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FolderElementUpdateDtoToJson(this);
}
