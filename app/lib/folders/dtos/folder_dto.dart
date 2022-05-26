import 'package:app/core/dtos/base_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'folder_dto.g.dart';

@JsonSerializable()
class FolderDto extends BaseDto {
  @JsonKey(required: true)
  late String folderName;

  @JsonKey(required: true)
  late List<String> labels;

  @JsonKey(required: true)
  late int numberRecords;

  FolderDto(String id, this.folderName, this.labels, this.numberRecords)
      : super(id);

  factory FolderDto.fromJson(Map<String, dynamic> json) =>
      _$FolderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FolderDtoToJson(this);
}
