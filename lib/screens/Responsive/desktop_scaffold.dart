import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/login_controller.dart';


class Desktop extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
                () => controller.googleAccount.value == null
                    ? builtLogin()
                    : builtProfile()
        ),
      ),
    );
  }

  FloatingActionButton builtLogin() {
    return FloatingActionButton.extended(
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
    );
  }

  Column builtProfile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundImage: Image.network(controller.googleAccount.value?.photoUrl??'').image,
          radius: 100,
        ),
        Text(controller.googleAccount.value?.displayName ?? ''),
        Text(controller.googleAccount.value?.email ?? '')
      ],
    );
  }
}
