import 'package:json_annotation/json_annotation.dart';

part 'create_user_dto.g.dart';

@JsonSerializable()
class CreateUserDto {
  @JsonKey(required: true)
  late String firstName;

  @JsonKey(required: true)
  late String lastName;

  @JsonKey(required: true)
  late String email;

  @JsonKey(required: true)
  late String password;

  late String phone;

  CreateUserDto(
      this.firstName, this.lastName, this.email, this.password, this.phone);

  factory CreateUserDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserDtoToJson(this);
}
