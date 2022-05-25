// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'firstName', 'lastName', 'email'],
  );
  return UserDto(
    json['id'] as String,
    json['firstName'] as String,
    json['lastName'] as String,
    json['email'] as String,
    json['phone'] as String,
  );
}

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
    };
