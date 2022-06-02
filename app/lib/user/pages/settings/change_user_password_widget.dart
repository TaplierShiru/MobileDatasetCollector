import 'package:flutter/material.dart';

import '../../../utils/validators/required_validator.dart';
import '../../../utils/validators/type_helpers.dart';
import '../../../utils/widgets/async_button.dart';
import '../../../utils/widgets/text_form_field.dart';

class ChangePasswordUserWidget extends StatefulWidget {
  const ChangePasswordUserWidget({Key? key}) : super(key: key);

  @override
  State<ChangePasswordUserWidget> createState() =>
      _ChangePasswordUserWidgetState();
}

class _ChangePasswordUserWidgetState extends State<ChangePasswordUserWidget> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Change profile password',
              style: TextStyle(color: Colors.blue, fontSize: 26),
              textAlign: TextAlign.center,
            ),
          ),
          TextFormFieldWidget(
            controller: oldPasswordController,
            labelText: 'Old password',
            hintText: 'Enter your old password',
          ),
          TextFormFieldWidget(
            controller: newPasswordController,
            labelText: 'Last name',
            hintText: 'Enter your last name',
          ),
          updateProfilePasswordButton(),
          const Padding(padding: EdgeInsets.only(bottom: 8)),
        ],
      ),
    );
  }

  Widget updateProfilePasswordButton() {
    return AsyncButton(
      onAsyncCall: () async {
        return true;
      },
      initButtonChild: const Text(
        'Update password',
        style: TextStyle(color: Colors.white, fontSize: 26),
      ),
    );
  }
}
