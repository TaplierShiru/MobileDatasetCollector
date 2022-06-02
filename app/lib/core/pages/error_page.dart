import 'package:app/core/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error page')),
      body: const Center(
        child: Text('Error page. Something went wrong...'),
      ),
      drawer: const DrawerMenuWidget(),
    );
  }
}
