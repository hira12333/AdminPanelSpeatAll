import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:speatall_admin/controllers/authServices.dart';

class ManageHaroofListView extends StatefulWidget {
  const ManageHaroofListView({Key? key}) : super(key: key);

  @override
  State<ManageHaroofListView> createState() => _ManageHaroofListViewState();
}

class _ManageHaroofListViewState extends State<ManageHaroofListView> {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    deleteHarf(id)async{
      _services.Haroof.doc(id).delete();
    }
    showMyDialog(title, message, context , id)async {
      return showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
        return AlertDialog(
          title: Center(
            child: Text(title),
          ),
            content: Text(message),
          actions:<Widget> [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Cancel')),
            TextButton(onPressed: (){
              deleteHarf(id);
              Navigator.of(context).pop();
            }, child: Text('Delete')),
          ],
        );
          });
    }
    Widget HaroofWidget(data){
      return Container(
        margin: EdgeInsets.all(20),
        width:300,
        height: 300,
          child: Stack(
            children:<Widget> [
              Positioned(
                  bottom: 0,
                  top: 0,
                  left: 0,
                  right: 0,

                  child: Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data['image']),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              ),

              Positioned(
                  bottom: 10,
                  right: 5,
                  child: CircleAvatar(
                backgroundColor: Colors.transparent,
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: (){
                      showMyDialog('Delete Harf', 'Are you sure ?', context, data.id);
                      },
                    ),
              )),
              Positioned(
                  top: 10,
                  left: 3,
                  child: Text(data['HaroofName'], style: TextStyle(
                    fontFamily: "Noori"
                  ),))
            ],
          ),
      );
    }
    return StreamBuilder<QuerySnapshot>(
      stream: _services.Haroof.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data?.size == 0) {
          return Center(
            child: Text("No Harf Added"),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
          ),
          itemCount: snapshot.data?.size,
          itemBuilder: (BuildContext context, int index) {
            var data = snapshot.data?.docs[index];
            return HaroofWidget(data);
          },
        );
      },
    );
  }
}
