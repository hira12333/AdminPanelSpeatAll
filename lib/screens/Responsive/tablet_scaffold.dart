import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/constants.dart';
import '../../constants/responsive.dart';
import '../../controllers/login_controller.dart';
class TabLayout extends StatefulWidget {
  const TabLayout({Key? key}) : super(key: key);

  @override
  State<TabLayout> createState() => _TabLayoutState();
}

class _TabLayoutState extends State<TabLayout> {
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Obx((

            ){
          if(controller.googleAccount.value==null)
            return builtLogin();
          else
            return builtProfile();

        }),
      ),
    );
  }
  Container builtLogin(){
    return Container(
      child:  FloatingActionButton.extended(
        onPressed: () {

          controller.login();
        },
        icon: Image.asset(
          'assets/images/google.png',
          height: 32,
          width: 32,
        ),
        label: Text(
          'Sign In with Google',
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    );
  }


  builtProfile() {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: Image.network(
            controller.googleAccount.value?.photoUrl ?? '',
            height: 38,
            width: 38,
            fit: BoxFit.cover,
          ).image,
          radius: 100,
        ),
        if(!Responsive.isMobile(context as BuildContext))
          Padding(
            padding: EdgeInsets.symmetric(horizontal: appPadding / 2),
            child: Column(
              children: [
                Text(controller.googleAccount.value?.displayName ?? '', style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w800
                ),),
                Text(controller.googleAccount.value?.email ?? '', style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w800
                ),)
              ],
            ),
          )

      ],
    );
  }

}
