// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_element_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FolderElementDto _$FolderElementDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'label',
      'imageUrl',
      'dateUploaded',
      'dateChanged',
      'lastUserChange'
    ],
  );
  return FolderElementDto(
    json['id'] as String,
    json['name'] as String,
    json['label'] as String,
    json['imageUrl'] as String,
    DateTime.parse(json['dateUploaded'] as String),
    DateTime.parse(json['dateChanged'] as String),
    UserDto.fromJson(json['lastUserChange'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FolderElementDtoToJson(FolderElementDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'label': instance.label,
      'imageUrl': instance.imageUrl,
      'dateUploaded': instance.dateUploaded.toIso8601String(),
      'dateChanged': instance.dateChanged.toIso8601String(),
      'lastUserChange': instance.lastUserChange,
    };
