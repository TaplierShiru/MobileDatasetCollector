import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widgets/drawer_menu.dart';

class MainPageWidget extends StatelessWidget {
  const MainPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Page')),
      body: Center(
        child: const Text('Main page'),
      ),
      drawer: DrawerMenuWidget(),
    );
  }
}
