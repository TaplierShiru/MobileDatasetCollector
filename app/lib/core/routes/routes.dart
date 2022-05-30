import 'package:app/folders/dtos/folder_element_dto.dart';
import 'package:app/folders/pages/single_folder_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../auth/pages/login/login.dart';
import '../../auth/pages/registration/registration.dart';
import '../../folders/pages/create_folder.dart';
import '../../folders/pages/create_folder_element.dart';
import '../../folders/pages/user_folders.dart';
import '../../user/pages/settings/settings_page.dart';
import '../pages/error_page/error_page.dart';
import '../pages/main_page/main_page.dart';

enum RouteEnum {
  initialRoute,
  authRoute,
  registrationRoute,

  homePageRoute,

  foldersRoute,
  createFolderRoute,
  singleFolderRoute,
  createFolderElementRoute,
  singleFolderElementRoute,

  settingsRoute,
  logoutRoute
}

extension AppRoute on RouteEnum {
  static const routes = {
    RouteEnum.initialRoute: '/',
    RouteEnum.authRoute: '/auth',
    RouteEnum.registrationRoute: '/auth/registration',
    RouteEnum.homePageRoute: '/home-page',
    // Single folder - /folders/:id
    RouteEnum.foldersRoute: '/folders',
    RouteEnum.createFolderRoute: '/folders/create',
    RouteEnum.singleFolderRoute: '/folders/id',
    RouteEnum.createFolderElementRoute: '/folders/id/element/create',
    RouteEnum.singleFolderElementRoute: '/folders/id/element/id',

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
      AppRoute.routes[RouteEnum.foldersRoute]!: (context) =>
          const MainPageWidget(),
      AppRoute.routes[RouteEnum.createFolderRoute]!: (context) =>
          const CreateFolderWidget(),
      AppRoute.routes[RouteEnum.settingsRoute]!: (context) =>
          const SettingsPage(),
    };
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var uri = Uri.parse(settings.name!);
    if (uri.path == AppRoute.routes[RouteEnum.logoutRoute]) {
      return MaterialPageRoute(builder: (_) => const LoginWidget());
    }
    if (uri.path == AppRoute.routes[RouteEnum.singleFolderRoute]) {
      return MaterialPageRoute(
        builder: (_) =>
            UserFoldersWidget(folderId: settings.arguments as String),
      );
    }
    if (uri.path == AppRoute.routes[RouteEnum.singleFolderElementRoute]) {
      final params = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => SingleFolderElementWidget(
          folderElementDto: params['folderElementDto'] as FolderElementDto,
          folderId: params['folderId'] as String,
        ),
      );
    }
    if (uri.path == AppRoute.routes[RouteEnum.createFolderElementRoute]) {
      return MaterialPageRoute(
        builder: (_) =>
            CreateFolderElementWidget(folderId: settings.arguments as String),
      );
    }
    return MaterialPageRoute(builder: (_) => const ErrorPage());
  }
}
