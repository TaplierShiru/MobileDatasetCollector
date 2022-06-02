import 'package:app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import '../../folders/widgets/folders.dart';
import '../widgets/drawer_menu.dart';

class MainPageWidget extends StatelessWidget {
  const MainPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Page')),
      body: const FoldersWidget(),
      drawer: const DrawerMenuWidget(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Go to folder creation page
            Navigator.pushNamed(
                context, AppRoute.routes[RouteEnum.createFolderRoute]!);
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add)),
    );
  }
}
