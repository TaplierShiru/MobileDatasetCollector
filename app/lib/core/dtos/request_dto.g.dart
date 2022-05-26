// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestDto _$RequestDtoFromJson(Map<String, dynamic> json) => RequestDto(
      $enumDecode(_$StatusCodeEnumMap, json['statusCode']),
    );

Map<String, dynamic> _$RequestDtoToJson(RequestDto instance) =>
    <String, dynamic>{
      'statusCode': _$StatusCodeEnumMap[instance.statusCode],
    };

const _$StatusCodeEnumMap = {
  StatusCode.success: 200,
  StatusCode.unauthorized: 401,
  StatusCode.wrongEntity: 500,
};
