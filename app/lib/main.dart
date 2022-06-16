import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user/view_model/user_view_model.dart';
import 'core/routes/routes.dart';
import 'folders/view_model/folders_view_model.dart';

// Image picker
// https://pub.dev/packages/image_picker

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => FoldersViewModel())
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
      theme: ThemeData(primaryColor: Colors.blue, errorColor: Colors.red),
      initialRoute: AppRoute.routes[RouteEnum.initialRoute],
      routes: AppRoute.getRoutesToWidget(context),
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}
