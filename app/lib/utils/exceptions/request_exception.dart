import '../../core/dtos/request_dto.dart';

class RequestException implements Exception {
  late RequestDto requestDto;
  RequestException({required this.requestDto});
}
