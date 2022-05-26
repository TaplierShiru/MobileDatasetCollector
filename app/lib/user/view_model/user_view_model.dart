import 'package:app/auth/services/auth_service.dart';
import 'package:app/user/services/current_user_service.dart';
import 'package:flutter/foundation.dart';

import '../../auth/dtos/create_user_dto.dart';
import '../../core/dtos/request_dto.dart';
import '../dtos/user_dto.dart';

class UserViewModel extends ChangeNotifier {
  final _userService = CurrentUserService();
  final _authService = AuthService();

  UserDto? get getCurrentUser {
    return _userService.currentUser;
  }

  set setCurrentUser(UserDto userDto) {
    _userService.currentUser = userDto;
  }

  Future<void> login(String email, String password) async {
    setCurrentUser = await _authService.login(email, password);
  }

  Future<RequestDto> register(CreateUserDto createUserDto) {
    return _authService.register(createUserDto);
  }
}
