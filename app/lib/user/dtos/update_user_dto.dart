import 'package:json_annotation/json_annotation.dart';

part 'update_user_dto.g.dart';

@JsonSerializable()
class UpdateUserDto {
  late String firstName;
  late String lastName;
  late String email;
  late String phone;

  UpdateUserDto(this.firstName, this.lastName, this.email, this.phone);

  factory UpdateUserDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserDtoToJson(this);
}
