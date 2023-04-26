import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/responsive.dart';
import '../../../components/drawer_menu.dart';
import 'Manage_preschool.dart';


class Preschool extends StatefulWidget {
  const Preschool({Key? key}) : super(key: key);

  @override
  State<Preschool> createState() => _ContentState();
}

class _ContentState extends State<Preschool>  {
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
                child: ManagePreschool(),
              ),
              const SizedBox(
                height: 30,
              ),
            ])));
  }
}
