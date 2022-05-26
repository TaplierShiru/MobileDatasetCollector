// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserDto _$UpdateUserDtoFromJson(Map<String, dynamic> json) =>
    UpdateUserDto(
      json['firstName'] as String,
      json['lastName'] as String,
      json['email'] as String,
      json['phone'] as String,
    );

Map<String, dynamic> _$UpdateUserDtoToJson(UpdateUserDto instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
    };
