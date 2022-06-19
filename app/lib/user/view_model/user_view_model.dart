import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../auth/services/auth_service.dart';
import '../services/current_user_service.dart';
import '../../auth/dtos/create_user_dto.dart';

class UserViewModel extends ChangeNotifier {
  final _authService = AuthService();

  get getCurrentUser {
    final currentUserService = Get.put(CurrentUserService());
    return currentUserService.currentUserDto;
  }

  Future<void> login(String email, String password) async {
    final currentUserService = Get.put(CurrentUserService());
    currentUserService.tokenDto =
        await _authService.login(http.Client(), email, password);
    currentUserService.updateCurrentUserDto(http.Client());
  }

  Future<bool> register(CreateUserDto createUserDto) {
    return _authService.register(http.Client(), createUserDto);
  }
}
