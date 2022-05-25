import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../auth/pages/login/login.dart';
import '../../auth/pages/registration/registration.dart';
import '../pages/error_page/error_page.dart';
import '../pages/main_page/main_page.dart';

enum RouteEnum {
  initialRoute,
  authRoute,
  registrationRoute,
  homePageRoute,
  myFoldersRoute,
  settingsRoute,
  logoutRoute
}

extension AppRoute on RouteEnum {
  static const routes = {
    RouteEnum.initialRoute: '/',
    RouteEnum.authRoute: '/auth',
    RouteEnum.registrationRoute: '/auth/registration',
    RouteEnum.homePageRoute: '/home-page',
    RouteEnum.myFoldersRoute: '/my-folders',
    RouteEnum.settingsRoute: '/settings',
    RouteEnum.logoutRoute: '/logout'
  };

  static Map<String, Widget Function(BuildContext)> getRoutesToWidget(
      BuildContext context) {
    return {
      AppRoute.routes[RouteEnum.initialRoute]!: (context) =>
          const LoginWidget(),
      AppRoute.routes[RouteEnum.authRoute]!: (context) => const LoginWidget(),
      AppRoute.routes[RouteEnum.registrationRoute]!: (context) =>
          const RegistrationWidget(),
      AppRoute.routes[RouteEnum.homePageRoute]!: (context) =>
          const MainPageWidget(),
      AppRoute.routes[RouteEnum.myFoldersRoute]!: (context) =>
          const MainPageWidget(),
      AppRoute.routes[RouteEnum.settingsRoute]!: (context) =>
          const MainPageWidget(),
    };
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var uri = Uri.parse(settings.name!);
    if (uri.path == AppRoute.routes[RouteEnum.logoutRoute]) {
      return MaterialPageRoute(builder: (_) => const LoginWidget());
    }
    return MaterialPageRoute(builder: (_) => const ErrorPage());
  }
}
