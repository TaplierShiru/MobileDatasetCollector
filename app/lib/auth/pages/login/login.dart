import 'package:app/utils/validators/required_validator.dart';
import 'package:app/auth/view_model/auth_view_model.dart';
import 'package:app/utils/widgets/async_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentState = AsyncButtonState.init;
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username/email',
                    hintText: 'Enter valid username or email',
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
              TextButton(
                onPressed: () {
                  // TODO: go to forgot password page
                },
                child: const Text(
                  'Forgot password',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ),
              AsyncButton(
                onAsyncCall: () async {
                  if (_formKey.currentState!.validate()) {
                    String usernameOrEmail = userNameController.text;
                    String password = passwordController.text;
                    bool result =
                        await Provider.of<AuthViewModel>(context, listen: false)
                            .login(usernameOrEmail, password);
                    if (!mounted) return false;
                    if (result) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login success')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Wrong username/email or password')));
                    }
                    return result;
                  }
                  return false;
                },
                initButtonChild: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 26),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/auth/registration');
                },
                child: const Text('New user? Create account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
