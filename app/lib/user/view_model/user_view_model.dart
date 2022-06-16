import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../auth/services/auth_service.dart';
import '../services/current_user_service.dart';
import '../../auth/dtos/create_user_dto.dart';
import '../dtos/user_dto.dart';

class UserViewModel extends ChangeNotifier {
  final _userService = CurrentUserService();
  final _authService = AuthService();

  UserDto? get getCurrentUser {
    return _userService.currentUserDto;
  }

  set setCurrentUser(UserDto userDto) {
    _userService.currentUserDto = userDto;
  }

  Future<void> login(String email, String password) async {
    _userService.tokenDto =
        await _authService.login(http.Client(), email, password);
    _userService.updateCurrentUserDto(http.Client());
  }

  Future<bool> register(CreateUserDto createUserDto) {
    return _authService.register(http.Client(), createUserDto);
  }
}
