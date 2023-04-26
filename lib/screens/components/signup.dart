import 'dart:html';
import 'dart:js';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speatall_admin/screens/dash_board_screen.dart';

import '../../constants/constants.dart';
import '../../constants/responsive.dart';
import '../../controllers/login_controller.dart';
import '../../firebase/auth_methods.dart';
import '../../firebase/reusable_widget.dart';
import '../../utils/utils.dart';

class Signp extends StatefulWidget {
  Signp({Key? key}) : super(key: key);

  @override
  State<Signp> createState() => _SignpState();
}

class _SignpState extends State<Signp> {

   //final Widget builtProfile;
  final controller = Get.put(LoginController());
  TextEditingController _passwordTextController = TextEditingController();

  TextEditingController _emailTextController = TextEditingController();

  TextEditingController _userNameTextController = TextEditingController();

  Uint8List? _image;

  bool _isLoading = false;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().SignupUser(
        email: _emailTextController.text,
        password: _passwordTextController.text,
        username: _userNameTextController.text,
        file: _image!);

    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context as BuildContext);
    } else {
      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  SignInScreen()));
    }
  }

  void NavigateToLogin() {
    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/adminbg.gif'),



        )
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.centerRight,
          child: Column(

            children: [
              Padding(
                padding: EdgeInsets.all(40),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.85,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey, spreadRadius: 4, blurRadius: 5)
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // Image(image: AssetImage('images/logo11.png'), height: 70,),
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : CircleAvatar(
                                radius: 64,
                                backgroundImage:
                                    AssetImage("assets/images/adminp.jpg")),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(
                              Icons.add_a_photo,
                            ),
                          ),
                        ),
                         SizedBox(
                          height: 10,
                        ),
                        reusableTextField(
                            "Enter UserName",
                            Icons.person_outline,
                            false,
                            _userNameTextController),
                         SizedBox(
                          height: 10,
                        ),
                        reusableTextField(
                            "Enter Email Id",
                            Icons.person_outline,
                            false,
                            _emailTextController),
                         SizedBox(
                          height: 10,
                        ),
                        reusableTextField(
                            "Enter Password",
                            Icons.lock_outlined,
                            true,
                            _passwordTextController),
                         SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: signUpUser,
                            child: Container(
                              child: _isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Sign Up',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                              //width: double.infinity,
                              alignment: Alignment.center,
                              padding:
                              EdgeInsets.symmetric(vertical: 10),
                              width: MediaQuery.of(context).size.width * 0.35,
                              decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                  ),
                                  color: Colors.greenAccent),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          child: Row(
                            children: [
                              Text(
                                '     Already have an accout  ',
                                style: TextStyle(fontSize: 17),

                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  " Log In",
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],

                          ),

                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          child: Obx(
                              (() {
                                if(controller.googleAccount.value!=null)
                                  return builtProfile();
                                else
                                  return builtProfile();

                              }),
                        ),
                        ),],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
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
            padding: const EdgeInsets.symmetric(horizontal: appPadding / 2),
            child: Column(
              children: [
                Text(controller.googleAccount.value?.displayName ?? '', style:
                    Get.textTheme.headline3,
                ),
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

