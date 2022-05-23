import 'package:flutter/cupertino.dart';

import '../services/auth-service.dart';

class AuthViewModel extends ChangeNotifier {
  final _authService = AuthService();

  Future<bool> login(String usernameOrEmail, String password) async {
    return await _authService.login(usernameOrEmail, password);
  }
}
