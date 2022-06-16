// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenDto _$TokenDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['access_token', 'token_type'],
  );
  return TokenDto(
    json['access_token'] as String,
    json['token_type'] as String,
  );
}

Map<String, dynamic> _$TokenDtoToJson(TokenDto instance) => <String, dynamic>{
      'access_token': instance.token,
      'token_type': instance.type,
    };
