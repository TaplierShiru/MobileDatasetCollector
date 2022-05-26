import 'package:app/user/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../utils/validators/required_validator.dart';
import '../../../utils/validators/type_helpers.dart';
import '../../../utils/widgets/async_button.dart';

class ChangeUserInfoWidget extends StatefulWidget {
  const ChangeUserInfoWidget({Key? key}) : super(key: key);

  @override
  State<ChangeUserInfoWidget> createState() => _ChangeUserInfoWidgetState();
}

class _ChangeUserInfoWidgetState extends State<ChangeUserInfoWidget> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentUserDto = context.watch<UserViewModel>().getCurrentUser!;
    firstNameController.text = currentUserDto.firstName;
    lastNameController.text = currentUserDto.lastName;
    emailController.text = currentUserDto.email;
    phoneController.text = currentUserDto.phone;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Change profile attributes',
              style: TextStyle(color: Colors.blue, fontSize: 26),
              textAlign: TextAlign.center,
            ),
          ),
          textFormField('First name', 'Enter your first name',
              firstNameController, requiredValidator),
          textFormField('Last name', 'Enter your last name', lastNameController,
              requiredValidator),
          textFormField(
              'Email', 'Enter your email', emailController, requiredValidator),
          textFormField(
              'Phone', 'Enter your phone', phoneController, requiredValidator),
          updateProfileButton(),
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

  Widget updateProfileButton() {
    return AsyncButton(
      onAsyncCall: () async {
        return true;
      },
      initButtonChild: const Text(
        'Update profile',
        style: TextStyle(color: Colors.white, fontSize: 26),
      ),
    );
  }
}
