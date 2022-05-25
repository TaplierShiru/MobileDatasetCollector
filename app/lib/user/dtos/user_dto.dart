import 'package:app/core/dtos/base_dto.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto extends BaseDto {
  @JsonKey(required: true)
  late String firstName;

  @JsonKey(required: true)
  late String lastName;

  @JsonKey(required: true)
  late String email;

  late String phone;

  UserDto(String id, this.firstName, this.lastName, this.email, this.phone)
      : super(id);

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
