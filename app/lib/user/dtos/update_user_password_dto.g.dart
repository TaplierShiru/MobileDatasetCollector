// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_password_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserPasswordDto _$UpdateUserPasswordDtoFromJson(
        Map<String, dynamic> json) =>
    UpdateUserPasswordDto(
      json['oldPassword'] as String,
      json['newPassword'] as String,
    );

Map<String, dynamic> _$UpdateUserPasswordDtoToJson(
        UpdateUserPasswordDto instance) =>
    <String, dynamic>{
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
    };
