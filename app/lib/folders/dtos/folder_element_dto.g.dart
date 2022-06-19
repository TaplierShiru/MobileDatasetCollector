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
      'image_url',
      'date_uploaded',
      'date_changed',
      'last_user_change'
    ],
  );
  return FolderElementDto(
    json['id'] as String,
    json['name'] as String,
    LabelDto.fromJson(json['label'] as Map<String, dynamic>),
    json['image_url'] as String,
    DateTime.parse(json['date_uploaded'] as String),
    DateTime.parse(json['date_changed'] as String),
    UserDto.fromJson(json['last_user_change'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FolderElementDtoToJson(FolderElementDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'label': instance.label,
      'image_url': instance.imageUrl,
      'date_uploaded': instance.dateUploaded.toIso8601String(),
      'date_changed': instance.dateChanged.toIso8601String(),
      'last_user_change': instance.lastUserChange,
    };
