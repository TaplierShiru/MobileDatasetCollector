// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FolderUpdateDto _$FolderUpdateDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'labels'],
  );
  return FolderUpdateDto(
    json['name'] as String,
    (json['labels'] as List<dynamic>)
        .map((e) => LabelUpdateDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FolderUpdateDtoToJson(FolderUpdateDto instance) =>
    <String, dynamic>{
      'name': instance.folderName,
      'labels': instance.labels,
    };
