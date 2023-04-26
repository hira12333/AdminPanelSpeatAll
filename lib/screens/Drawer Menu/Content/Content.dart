import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../constants/responsive.dart';
import '../../../controllers/controller.dart';
import '../../components/dashoboard_content.dart';
import '../../components/drawer_menu.dart';
import 'Manage Content.dart';

class Content extends StatefulWidget {
  const Content({Key? key}) : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        drawer: DrawerMenu(),
       // key: context.read<Controller>().scaffoldKey,
        body: SafeArea(
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (Responsive.isDesktop(context))
            Expanded(
              child: DrawerMenu(),
            ),
          Expanded(
            flex: 5,
            child: ManageContent(),
          ),
          const SizedBox(
            height: 30,
          ),
        ])));
  }
}
