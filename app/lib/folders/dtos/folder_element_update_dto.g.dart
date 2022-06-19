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
    LabelDto.fromJson(json['label'] as Map<String, dynamic>),
    json['image_file'] as String?,
  );
}

Map<String, dynamic> _$FolderElementUpdateDtoToJson(
        FolderElementUpdateDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'image_file': instance.imageFile,
    };
