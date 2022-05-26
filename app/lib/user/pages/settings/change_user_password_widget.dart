import 'package:flutter/material.dart';

import '../../../utils/validators/required_validator.dart';
import '../../../utils/validators/type_helpers.dart';
import '../../../utils/widgets/async_button.dart';

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
          textFormField('Old password', 'Enter your old password',
              oldPasswordController, requiredValidator),
          textFormField('Last name', 'Enter your last name',
              newPasswordController, requiredValidator),
          updateProfilePasswordButton(),
          const Padding(padding: EdgeInsets.only(bottom: 8)),
        ],
      ),
    );
  }

  Widget textFormField(String labelText, String hintText,
      TextEditingController controller, ValidatorCall validator) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
        ),
        validator: validator,
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
