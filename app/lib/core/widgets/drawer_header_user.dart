import 'package:flutter/material.dart';

import '../../user/widgets/user_info_widget.dart';

class DrawerHeaderUserWidget extends StatelessWidget {
  const DrawerHeaderUserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: DrawerHeader(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: const UserInfoWidget(),
      ),
    );
  }
}
