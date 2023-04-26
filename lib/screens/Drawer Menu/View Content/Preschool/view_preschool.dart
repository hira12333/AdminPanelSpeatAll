import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/responsive.dart';
import '../../../components/drawer_menu.dart';
import 'manage_view_preschool.dart';



class ViewPreschool extends StatefulWidget {
  const ViewPreschool({Key? key}) : super(key: key);

  @override
  State<ViewPreschool> createState() => _ContentState();
}

class _ContentState extends State<ViewPreschool>  {
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
                child: ManageViewPreschool(),
              ),
              const SizedBox(
                height: 30,
              ),
            ])));
  }
}
