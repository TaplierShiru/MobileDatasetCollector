import 'dart:convert';
import 'package:app/auth/pages/login/login.dart';
import 'package:app/auth/pages/registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app/environment/environment.dart';
import 'package:provider/provider.dart';

import 'auth/view_model/auth_view_model.dart';

Future<String> testServer(http.Client client) async {
  final response =
      await client.get(Uri.parse(Environment.appendToApiUrl(['auth'])));

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['message'];
  }
  throw Exception('Failed to test server');
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginWidget(),
        '/auth': (context) => const LoginWidget(),
        '/auth/registration': (context) => const RegistrationWidget()
      },
    );
  }
}
