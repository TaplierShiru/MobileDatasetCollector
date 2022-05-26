import 'package:app/user/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({Key? key}) : super(key: key);

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    var currentUserDto = context.watch<UserViewModel>().getCurrentUser!;
    return SizedBox(
      child: Column(
        children: <Widget>[
          Text('${currentUserDto.firstName} ${currentUserDto.lastName}'),
          Text(currentUserDto.email, style: const TextStyle(fontSize: 14)),
          Text(currentUserDto.phone, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
