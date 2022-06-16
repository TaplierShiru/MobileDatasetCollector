import 'package:app/user/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/widgets/async_button.dart';
import '../../../utils/widgets/text_form_field.dart';

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
          TextFormFieldWidget(
            controller: firstNameController,
            labelText: 'First name',
            hintText: 'Enter your first name',
          ),
          TextFormFieldWidget(
            controller: lastNameController,
            labelText: 'Last name',
            hintText: 'Enter your last name',
          ),
          TextFormFieldWidget(
            controller: emailController,
            labelText: 'Email',
            hintText: 'Enter your email',
          ),
          TextFormFieldWidget(
            controller: phoneController,
            labelText: 'Phone',
            hintText: 'Enter your phone',
          ),
          updateProfileButton(),
          const Padding(padding: EdgeInsets.only(bottom: 8)),
        ],
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
