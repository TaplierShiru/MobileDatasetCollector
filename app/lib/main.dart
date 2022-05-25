import 'dart:convert';
import 'package:app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app/environment/environment.dart';
import 'package:provider/provider.dart';
import 'user/view_model/user_view_model.dart';

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
      providers: [ChangeNotifierProvider(create: (context) => UserViewModel())],
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
      theme: ThemeData(primaryColor: Colors.blue, errorColor: Colors.red),
      initialRoute: AppRoute.routes[RouteEnum.initialRoute],
      routes: AppRoute.getRoutesToWidget(context),
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}
