import 'package:json_annotation/json_annotation.dart';

part 'filter_parameters_dto.g.dart';

@JsonSerializable()
class FilterParametersDto {
  late String search;

  FilterParametersDto(this.search);

  factory FilterParametersDto.fromJson(Map<String, dynamic> json) =>
      _$FilterParametersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FilterParametersDtoToJson(this);
}
