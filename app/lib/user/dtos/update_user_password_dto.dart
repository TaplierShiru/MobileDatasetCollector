import 'package:json_annotation/json_annotation.dart';

part 'update_user_password_dto.g.dart';

@JsonSerializable()
class UpdateUserPasswordDto {
  late String oldPassword;
  late String newPassword;

  UpdateUserPasswordDto(this.oldPassword, this.newPassword);

  factory UpdateUserPasswordDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserPasswordDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserPasswordDtoToJson(this);
}
