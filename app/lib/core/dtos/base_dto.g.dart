// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseDto _$BaseDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id'],
  );
  return BaseDto(
    json['id'] as String,
  );
}

Map<String, dynamic> _$BaseDtoToJson(BaseDto instance) => <String, dynamic>{
      'id': instance.id,
    };
