import 'package:json_annotation/json_annotation.dart';

part 'token_dto.g.dart';

@JsonSerializable()
class TokenDto {
  @JsonKey(required: true, name: 'access_token')
  late String token;

  @JsonKey(required: true, name: 'token_type')
  late String type;

  TokenDto(this.token, this.type);

  factory TokenDto.fromJson(Map<String, dynamic> json) =>
      _$TokenDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TokenDtoToJson(this);
}
