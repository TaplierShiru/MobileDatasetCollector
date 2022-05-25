import 'package:app/user/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerHeaderUserWidget extends StatefulWidget {
  const DrawerHeaderUserWidget({Key? key}) : super(key: key);

  @override
  State<DrawerHeaderUserWidget> createState() => _DrawerHeaderUserWidgetState();
}

class _DrawerHeaderUserWidgetState extends State<DrawerHeaderUserWidget> {
  @override
  Widget build(BuildContext context) {
    var currentUserDto = context.watch<UserViewModel>().getCurrentUser!;
    return SizedBox(
      height: 140,
      child: DrawerHeader(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Column(
          children: <Widget>[
            Text('${currentUserDto.firstName} ${currentUserDto.lastName}'),
            Text(currentUserDto.email, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
