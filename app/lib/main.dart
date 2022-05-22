import 'dart:convert';

import 'package:app/environment/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> testServer(http.Client client) async {
  final response = await client.get(Uri.parse(Environment.apiUrl + '/auth'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['message'];
  }
  throw Exception('Failed to test server');
}

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<String> serverTest;

  @override
  void initState() {
    super.initState();
    serverTest = getMessage(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                const Text('Is server acceptable?'),
                FutureBuilder<String>(
                  future: serverTest,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const Icon(Icons.add);
                    } else if (snapshot.hasError) {
                      const Icon(Icons.close);
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getMessage(http.Client client) async {
    return await testServer(client);
  }
}
