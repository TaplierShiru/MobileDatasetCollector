import 'package:json_annotation/json_annotation.dart';

import '../../shared/dtos/label_update_dto.dart';

part 'folder_update_dto.g.dart';

@JsonSerializable()
class FolderUpdateDto {
  @JsonKey(required: true, name: 'name')
  late String folderName;

  @JsonKey(required: true)
  late List<LabelUpdateDto> labels;

  FolderUpdateDto(this.folderName, this.labels);

  factory FolderUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$FolderUpdateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FolderUpdateDtoToJson(this);
}
