import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/responsive.dart';
import '../../components/drawer_menu.dart';
import 'manage_View_content.dart';


class ViewContent extends StatefulWidget {
  const ViewContent({Key? key}) : super(key: key);

  @override
  State<ViewContent> createState() => _ContentState();
}

class _ContentState extends State<ViewContent>  {
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
                child: ManageContentView(),
              ),
              const SizedBox(
                height: 30,
              ),
            ])));
  }
}
