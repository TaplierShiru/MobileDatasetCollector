import 'package:app/user/dtos/user_dto.dart';
import 'package:flutter/cupertino.dart';

class CurrentUserService extends ChangeNotifier {
  UserDto? _currentUserDto;

  set currentUser(UserDto? currentUserDto) {
    _currentUserDto = currentUserDto;
  }

  UserDto? get currentUser {
    return _currentUserDto;
  }
}
