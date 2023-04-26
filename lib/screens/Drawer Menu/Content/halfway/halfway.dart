import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/responsive.dart';
import '../../../components/drawer_menu.dart';
import 'Manage_halfway.dart';



class Halfway extends StatefulWidget {
  const Halfway({Key? key}) : super(key: key);

  @override
  State<Halfway> createState() => _HalfwayState();
}

class _HalfwayState extends State<Halfway>  {
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
                child: ManageHalfway(),
              ),
              const SizedBox(
                height: 30,
              ),
            ])));
  }
}
