// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserDto _$CreateUserDtoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['firstName', 'lastName', 'email', 'password'],
  );
  return CreateUserDto(
    json['firstName'] as String,
    json['lastName'] as String,
    json['email'] as String,
    json['password'] as String,
    json['phone'] as String,
  );
}

Map<String, dynamic> _$CreateUserDtoToJson(CreateUserDto instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
    };
