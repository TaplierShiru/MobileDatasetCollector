import '../../core/utils/status_code_enum.dart';

class RequestException implements Exception {
  late StatusCode statusCode;
  RequestException({required this.statusCode});
}
