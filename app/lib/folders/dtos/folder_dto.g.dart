// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FolderDto _$FolderDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name', 'labels', 'number_records'],
  );
  return FolderDto(
    json['id'] as String,
    json['name'] as String,
    (json['labels'] as List<dynamic>)
        .map((e) => LabelDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['number_records'] as int,
  );
}

Map<String, dynamic> _$FolderDtoToJson(FolderDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.folderName,
      'labels': instance.labels,
      'number_records': instance.numberRecords,
    };
