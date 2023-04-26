import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import 'Haroof/Haroof.dart';


class ManagePreschool extends StatefulWidget {
  const ManagePreschool({Key? key}) : super(key: key);

  @override
  State<ManagePreschool> createState() => _ManageContentState();
}

class _ManageContentState extends State<ManagePreschool> {
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  Haroof()));
                    },
                    child: Container(
                      height: 200,
                      width: 400,
                      padding: EdgeInsets.all(appPadding),
                      decoration: BoxDecoration(
                          color: Colors.cyan.shade100,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Manage Haroof", style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15
                                )
                                ),
                                Image(
                                    image:
                                    AssetImage("assets/images/alifbay.png" ,  ),
                                    //color: Color(0xFF3A5A98),
                                    height: 50),
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
                      width: 400,
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
                                Text("Manage Names", style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15
                                )
                                ),
                                Image(
                                    image:
                                    AssetImage("assets/images/names.jpg" ,  ),
                                    //color: Color(0xFF3A5A98),
                                    height: 50),
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
