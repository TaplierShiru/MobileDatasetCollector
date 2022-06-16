import 'package:app/core/routes/routes.dart';
import 'package:app/core/utils/status_code_enum.dart';
import 'package:app/user/view_model/user_view_model.dart';
import 'package:app/utils/widgets/async_button.dart';
import 'package:app/utils/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/exceptions/request_exception.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final userEmailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userEmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Container(
                  height: 150.0,
                  width: 190.0,
                  padding: const EdgeInsets.only(top: 40),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(200)),
                  child: Center(
                      child: Image.asset('assets/logo/flutter-logo.png')),
                ),
              ),
              TextFormFieldWidget(
                controller: userEmailController,
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
              TextFormFieldWidget(
                controller: passwordController,
                labelText: 'Password',
                hintText: 'Enter your password',
              ),
              forgotButton(),
              loginButton(),
              createAccountButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return AsyncButton(
      onAsyncCall: () async {
        if (_formKey.currentState!.validate()) {
          String usernameOrEmail = userEmailController.text;
          String password = passwordController.text;
          try {
            await Provider.of<UserViewModel>(context, listen: false)
                .login(usernameOrEmail, password);

            if (!mounted) return false;
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Login success')));
            Navigator.pushNamed(
                context, AppRoute.routes[RouteEnum.homePageRoute]!);

            return true;
          } on RequestException catch (e) {
            if (e.statusCode == StatusCode.unauthorized) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Wrong username/email or password')));
            }
          }
        }
        return false;
      },
      initButtonChild: const Text(
        'Login',
        style: TextStyle(color: Colors.white, fontSize: 26),
      ),
    );
  }

  Widget forgotButton() {
    return TextButton(
      onPressed: () {
        // TODO: go to forgot password page
      },
      child: const Text(
        'Forgot password',
        style: TextStyle(color: Colors.blue, fontSize: 14),
      ),
    );
  }

  Widget createAccountButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(
            context, AppRoute.routes[RouteEnum.registrationRoute]!);
      },
      child: const Text('New user? Create account'),
    );
  }
}
