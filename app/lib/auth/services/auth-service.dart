import 'dart:io';

class AuthService {
  Future<bool> login(String usernameOrEmail, String password) async {
    await Future.delayed(const Duration(seconds: 4));
    if (usernameOrEmail == 'admin' && password == 'admin') {
      return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }
}
