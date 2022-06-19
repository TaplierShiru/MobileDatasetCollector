// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabelDto _$LabelDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name'],
  );
  return LabelDto(
    json['id'],
    json['name'] as String,
  );
}

Map<String, dynamic> _$LabelDtoToJson(LabelDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
