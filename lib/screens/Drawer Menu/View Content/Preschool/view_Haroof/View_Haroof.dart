import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/constants.dart';
import '../../../../../constants/responsive.dart';
import '../../../../components/drawer_menu.dart';
import 'Manage_view_haroof.dart';



class ViewHaroof extends StatefulWidget {
  const ViewHaroof({Key? key}) : super(key: key);

  @override
  State<ViewHaroof> createState() => _ContentState();
}

class _ContentState extends State<ViewHaroof>  {
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
                child: ManageHaroofListView(),
              ),
              const SizedBox(
                height: 30,
              ),
            ])));
  }
}
