import 'package:flutter/material.dart';
import '../../../../../constants/constants.dart';
import '../../../../../constants/responsive.dart';
import '../../../../components/drawer_menu.dart';
import 'manage_haroof.dart';

class Haroof extends StatefulWidget {
  const Haroof({Key? key}) : super(key: key);

  @override
  State<Haroof> createState() => _ContentState();
}

class _ContentState extends State<Haroof>  {
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
                child: ManageHaroof(),
              ),
              const SizedBox(
                height: 30,
              ),
            ])));
  }
}
