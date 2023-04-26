import 'package:flutter/material.dart';
import 'package:speatall_admin/screens/Drawer%20Menu/Content/halfway/Sequences/Counting/Manage_counting.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../../constants/responsive.dart';
import '../../../../../components/drawer_menu.dart';

import '../../../pre-school/Haroof/manage_haroof.dart';


class Counting extends StatefulWidget {
  const Counting({Key? key}) : super(key: key);

  @override
  State<Counting> createState() => _CountingState();
}

class _CountingState extends State<Counting>  {
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
                child: ManageCounting(),
              ),
              const SizedBox(
                height: 30,
              ),
            ])));
  }
}
