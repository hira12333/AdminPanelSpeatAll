import 'package:flutter/material.dart';
import 'package:speatall_admin/screens/Drawer%20Menu/Content/pre-school/preschool.dart';
import 'package:speatall_admin/screens/Drawer%20Menu/View%20Content/Preschool/view_preschool.dart';

import '../../../constants/constants.dart';
class ManageContentView extends StatefulWidget {
  const ManageContentView({Key? key}) : super(key: key);

  @override
  State<ManageContentView> createState() => _ManageContentState();
}

class _ManageContentState extends State<ManageContentView> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  ViewPreschool()));
                    },
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width*0.2,
                      padding: EdgeInsets.all(appPadding),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("View Pre-school", style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15
                                )
                                ),
                                Image(
                                    image:
                                    AssetImage("assets/images/babypin.png" ,  ),
                                    //color: Color(0xFF3A5A98),
                                    height: MediaQuery.of(context).size.height*0.02),
                              ],
                            ),
                            SizedBox(
                              height: appPadding,
                            ),
                          ]),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width*0.2,
                      padding: EdgeInsets.all(appPadding),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("View Halfway", style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15
                                )
                                ),
                                Image(
                                    image:
                                    AssetImage("assets/images/half.jpg" ,  ),
                                    //color: Color(0xFF3A5A98),
                                    height: MediaQuery.of(context).size.height*0.02),
                              ],
                            ),
                            SizedBox(
                              height: appPadding,
                            ),
                          ]),

                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
