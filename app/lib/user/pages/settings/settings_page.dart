import 'package:flutter/material.dart';

import 'change_user_info_widget.dart';
import 'change_user_password_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            ChangeUserInfoWidget(),
            ChangePasswordUserWidget()
          ],
        ),
      ),
    );
  }
}
