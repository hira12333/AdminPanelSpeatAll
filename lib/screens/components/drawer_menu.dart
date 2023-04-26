import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speatall_admin/screens/Drawer%20Menu/View%20Content/view_content.dart';

import '../../constants/constants.dart';
import '../../controllers/controller.dart';
import '../Drawer Menu/Content/Content.dart';
import 'drawer_list_tile.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(appPadding),
            child: Image.asset('assets/images/logowithtext.png'),
          ),
          DrawerListTile(
              title: 'Dash Board',
              svgSrc: 'assets/icons/Dashboard.svg',
              tap: () {}
              ),
              DrawerListTile(
              title: 'Manage Content',
              svgSrc: 'assets/icons/BlogPost.svg',
              tap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  Content()));
              }
              ),
              DrawerListTile(
              title: 'Users',
              svgSrc: 'assets/icons/Message.svg',
              tap: () {}
              ),
              DrawerListTile(
              title: 'Statistics',
              svgSrc: 'assets/icons/Statistics.svg',
              tap: () {
                }
              ),
          DrawerListTile(
              title: 'View Content',
              svgSrc: 'assets/icons/Statistics.svg',
              tap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  ViewContent()));
              }
          ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: appPadding * 2),
                child: Divider(
                  color: grey,
                  thickness: 0.2,
                ),
              ),
              DrawerListTile(
              title: 'Settings',
              svgSrc: 'assets/icons/Setting.svg',
              tap: () {}
              ),
              DrawerListTile(
              title: 'Log Out',
              svgSrc: 'assets/icons/Logout.svg',
              tap: () {}
              ),
        ],
      ),
    );
  }
}
