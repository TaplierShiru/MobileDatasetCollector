import 'package:app/auth/dtos/create_user_dto.dart';
import 'package:app/core/utils/status_code_enum.dart';

import '../../core/dtos/request_dto.dart';
import '../../user/dtos/user_dto.dart';
import '../../utils/exceptions/request_exception.dart';

class AuthService {
  Future<UserDto> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 4));

    if (email == 'admin' && password == 'admin') {
      var userDto = UserDto(
          '0', 'admin', 'admin-o', "email@email.com", '+7 902 238 2444');
      return Future<UserDto>.value(userDto);
    }

    throw RequestException(requestDto: RequestDto(StatusCode.unauthorized));
  }

  Future<RequestDto> register(CreateUserDto createUserDto) async {
    await Future.delayed(const Duration(seconds: 4));
    return Future<RequestDto>.value(RequestDto(StatusCode.success));
  }
}
