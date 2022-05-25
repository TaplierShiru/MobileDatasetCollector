import 'package:app/auth/dtos/create_user_dto.dart';
import 'package:app/core/utils/status_code_enum.dart';
import 'package:app/user/view_model/user_view_model.dart';
import 'package:app/utils/validators/required_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/dtos/request_dto.dart';
import '../../../utils/validators/type_helpers.dart';
import '../../../utils/widgets/async_button.dart';

class RegistrationWidget extends StatefulWidget {
  const RegistrationWidget({Key? key}) : super(key: key);

  @override
  State<RegistrationWidget> createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  final phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Page'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Please fill info below in order to register',
                  style: TextStyle(color: Colors.blue, fontSize: 26),
                  textAlign: TextAlign.center,
                ),
              ),
              textFormField('First name', 'Enter your first name',
                  firstNameController, requiredValidator),
              textFormField('Last name', 'Enter your last name',
                  lastNameController, requiredValidator),
              textFormField('Email', 'Enter your email', emailController,
                  requiredValidator),
              textFormField('Password', 'Enter your password',
                  passwordController, requiredValidator),
              textFormField('Repeat password', 'Repeat password your password',
                  repeatPasswordController, (value) {
                String? passwordCheck =
                    requiredValidator(passwordController.text);
                String? repeatPasswordCheck = requiredValidator(value);
                if (passwordCheck == null && repeatPasswordCheck == null) {
                  if (passwordController.text != value) {
                    return 'Passwords do not match';
                  }
                }
                return repeatPasswordCheck;
              }),
              registerButton()
            ],
          ),
        ),
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

  Widget registerButton() {
    return AsyncButton(
      onAsyncCall: () async {
        if (_formKey.currentState!.validate()) {
          var createUserDto = CreateUserDto(
              firstNameController.text,
              lastNameController.text,
              emailController.text,
              passwordController.text,
              phoneController.text);
          RequestDto result =
              await Provider.of<UserViewModel>(context, listen: false)
                  .register(createUserDto);

          if (!mounted) return false;
          if (result.statusCode == StatusCode.success) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Succefuly registered'),
            ));
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
            return true;
          }
        }
        if (!mounted) return false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error while registered. Check your input data'),
        ));
        return false;
      },
      initButtonChild: const Text(
        'Register',
        style: TextStyle(color: Colors.white, fontSize: 26),
      ),
    );
  }
}
