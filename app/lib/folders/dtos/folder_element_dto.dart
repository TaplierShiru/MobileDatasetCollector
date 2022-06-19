import 'package:app/core/dtos/base_dto.dart';
import 'package:app/shared/dtos/label_dto.dart';
import 'package:app/user/dtos/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'folder_element_dto.g.dart';

@JsonSerializable()
class FolderElementDto extends BaseDto {
  @JsonKey(required: true)
  late String name;

  @JsonKey(required: true)
  late LabelDto label;

  @JsonKey(required: true, name: 'image_url')
  late String imageUrl;

  @JsonKey(required: true, name: 'date_uploaded')
  late DateTime dateUploaded;

  @JsonKey(required: true, name: 'date_changed')
  late DateTime dateChanged;

  @JsonKey(required: true, name: 'last_user_change')
  late UserDto lastUserChange;

  FolderElementDto(String id, this.name, this.label, this.imageUrl,
      this.dateUploaded, this.dateChanged, this.lastUserChange)
      : super(id);

  factory FolderElementDto.fromJson(Map<String, dynamic> json) =>
      _$FolderElementDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FolderElementDtoToJson(this);
}
