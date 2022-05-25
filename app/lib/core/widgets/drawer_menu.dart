import 'package:app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'drawer_header_user.dart';

class DrawerMenuWidget extends StatelessWidget {
  const DrawerMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeaderUserWidget(),
          drawerListTile(
              context, 'Home page', Icons.home, RouteEnum.homePageRoute),
          drawerListTile(
              context, 'My folders', Icons.folder, RouteEnum.myFoldersRoute),
          drawerListTile(
              context, 'Settings', Icons.settings, RouteEnum.settingsRoute),
          drawerListTile(
              context, 'Exit', Icons.exit_to_app, RouteEnum.logoutRoute),
        ],
      ),
    );
  }

  Widget drawerListTile(
      BuildContext context, String title, IconData icon, RouteEnum route) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: () {
        Navigator.pushNamed(context, AppRoute.routes[route]!);
      },
    );
  }
}
