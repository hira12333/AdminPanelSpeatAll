import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:speatall_admin/controllers/authServices.dart';
import 'package:speatall_admin/data/data.dart';
import 'package:speatall_admin/screens/Drawer%20Menu/Content/pre-school/preschool.dart';
import 'package:speatall_admin/screens/Drawer%20Menu/View%20Content/Preschool/view_Haroof/View_Haroof.dart';

import '../../../../constants/constants.dart';
class ManageViewPreschool extends StatefulWidget {
  const ManageViewPreschool({Key? key}) : super(key: key);

  @override
  State<ManageViewPreschool> createState() => _ManageContentState();
}

class _ManageContentState extends State<ManageViewPreschool> {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    Widget analyticWidget({required String title, required String value}){
      return  Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title ,style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(value),
                    Icon(Icons.show_chart),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  ViewHaroof()));

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _services.Haroof.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.hasError){
                    return Text('Something went wrong');
                  }
                  if(snapshot.connectionState== ConnectionState.waiting){
                    return Padding(padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black87),
                          color: Colors.black12
                        ),
                        child: Center(
                          child: CircularProgressIndicator
                            (
                            color:  Colors.grey,
                          ),
                        ),
                      ),

                    );
                  }return analyticWidget(title: "Total Haroof", value: snapshot.data!.size.toString());
                  if ( snapshot.hasData){

                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
