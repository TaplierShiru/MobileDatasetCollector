// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_element_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FolderElementUpdateDto _$FolderElementUpdateDtoFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'label'],
  );
  return FolderElementUpdateDto(
    json['name'] as String,
    json['label'] as String,
    json['imageFile'] as String,
  );
}

Map<String, dynamic> _$FolderElementUpdateDtoToJson(
        FolderElementUpdateDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'imageFile': instance.imageFile,
    };
