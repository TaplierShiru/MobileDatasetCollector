// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_element_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FolderElementUpdateDto _$FolderElementUpdateDtoFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'name',
      'label',
      'imageUrl',
      'dateUploaded',
      'dateChanged',
      'lastUserChange'
    ],
  );
  return FolderElementUpdateDto(
    json['name'] as String,
    json['label'] as String,
    json['imageUrl'] as String,
    DateTime.parse(json['dateUploaded'] as String),
    DateTime.parse(json['dateChanged'] as String),
    UserDto.fromJson(json['lastUserChange'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FolderElementUpdateDtoToJson(
        FolderElementUpdateDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'imageUrl': instance.imageUrl,
      'dateUploaded': instance.dateUploaded.toIso8601String(),
      'dateChanged': instance.dateChanged.toIso8601String(),
      'lastUserChange': instance.lastUserChange,
    };
