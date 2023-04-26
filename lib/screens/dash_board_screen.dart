import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:speatall_admin/controllers/authServices.dart';
import 'package:speatall_admin/controllers/login_controller.dart';
import '../constants/constants.dart';
import '../constants/responsive.dart';
import '../controllers/controller.dart';
import 'components/dashoboard_content.dart';
import 'components/drawer_menu.dart';
import 'package:provider/provider.dart';


class DashBoardScreen extends StatelessWidget {

   DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: DrawerMenu(),
      key: context.read<Controller>().scaffoldKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(Responsive.isDesktop(context)) Expanded(child: DrawerMenu(),),
            Expanded(
              flex: 5,
              child: DashBoardContent(),
              ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              padding: const EdgeInsets.all(10),
              color: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: const Text(
                'LOG OUT',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () {
             //   AuthServices().signOut();
              },
            ),
        ],
        )
        ),
    );
  }
}