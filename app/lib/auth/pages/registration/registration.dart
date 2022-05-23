import 'package:app/utils/validators/required_validator.dart';
import 'package:flutter/material.dart';

class RegistrationWidget extends StatefulWidget {
  const RegistrationWidget({Key? key}) : super(key: key);

  @override
  State<RegistrationWidget> createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter valid username',
                  ),
                  validator: requiredValidator,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email',
                  ),
                  validator: requiredValidator,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password',
                  ),
                  validator: requiredValidator,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextFormField(
                  controller: repeatPasswordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Repeat password',
                    hintText: 'Repeat password',
                  ),
                  validator: (value) {
                    String? passwordCheck =
                        requiredValidator(passwordController.text);
                    String? repeatPasswordCheck = requiredValidator(value);
                    if (passwordCheck == null && repeatPasswordCheck == null) {
                      if (passwordController.text != value) {
                        return 'Passwords do not match';
                      }
                    }
                    return repeatPasswordCheck;
                  },
                ),
              ),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Check username/password and go to home page
                    }
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 26),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
