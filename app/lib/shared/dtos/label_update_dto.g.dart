// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabelUpdateDto _$LabelUpdateDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name'],
  );
  return LabelUpdateDto(
    json['name'] as String,
  );
}

Map<String, dynamic> _$LabelUpdateDtoToJson(LabelUpdateDto instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
