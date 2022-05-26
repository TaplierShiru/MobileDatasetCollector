// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FolderDto _$FolderDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'folderName', 'labels', 'numberRecords'],
  );
  return FolderDto(
    json['id'] as String,
    json['folderName'] as String,
    (json['labels'] as List<dynamic>).map((e) => e as String).toList(),
    json['numberRecords'] as int,
  );
}

Map<String, dynamic> _$FolderDtoToJson(FolderDto instance) => <String, dynamic>{
      'id': instance.id,
      'folderName': instance.folderName,
      'labels': instance.labels,
      'numberRecords': instance.numberRecords,
    };
