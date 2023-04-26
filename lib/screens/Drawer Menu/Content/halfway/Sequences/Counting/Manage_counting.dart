import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:html' as html;
import '../../../../../../controllers/authServices.dart';


class ManageCounting extends StatefulWidget {
  @override
  State<ManageCounting> createState() => _ManageCountingState();
}

class _ManageCountingState extends State<ManageCounting> {
  //const ManageHaroof({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  FirebaseServices _services = FirebaseServices();

  final TextEditingController _numberName = TextEditingController();
  dynamic image;
  String? fileName;

  html.File? _audio;
  String? _audioUrl;
  Future<String?> uploadAudio() async {
    if (_audio == null) {
      return null;
    }
    final String fileName = '${DateTime.now().millisecondsSinceEpoch}.mp3';
    final Reference ref = FirebaseStorage.instance.ref().child('audios/$fileName');
    final UploadTask task = ref.putBlob(_audio);
    final TaskSnapshot snapshot = await task.whenComplete(() {});
    final String url = await snapshot.ref.getDownloadURL();

    setState(() {
      _audioUrl = url;
    });
  }


  void selectAudioFile() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'audio/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final html.File file = uploadInput.files!.first;
      setState(() {
        _audio = file;
      });
    });
  }
  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        image = result?.files.first.bytes;
        fileName = result?.files.first.name;
      });
    } else {
      print("No Image Selected");
    }
  }

  clean() {
    setState(() {
      _numberName.clear();
      image == null;
    });
  }

  SaveDatatoFirebase() async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('gs://speatalladmin.appspot.com/GintiImages/$fileName');
    EasyLoading.show(status: "Loading");
    try {
      if (_audioUrl == null || image == null) {
        return;
      }
      await _services.counting.add({
        'number': _numberName.text,
        'audioUrl': _audioUrl,
        'imageUrl': image,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data saved successfully.'),
        duration: Duration(seconds: 2),
      )); //get downlaad lonk
    } on firebase_core.FirebaseException catch (e) {
      print(e.toString());
      clean();
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    //String videoName = video != null ? video!.name : "No file selected";
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Counting",
                  style: TextStyle(color: Colors.blue, fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Container(
                          height: 200,
                          width: 200,
                          // color: Colors.blueGrey,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.blue, width: 2)),
                          child: InkWell(
                              onTap: () {
                                pickImage();
                              },
                              child: image == null
                                  ? Center(child: Icon(Icons.file_upload))
                                  : Image.memory(
                                image,
                                fit: BoxFit.cover,
                              ))),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          Container(
                            width: 200,
                            child: TextFormField(
                              controller: _numberName,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  label: Text(
                                    "Enter Number Name",
                                    style: TextStyle(fontFamily: 'Noori'),
                                  ),
                                  contentPadding: EdgeInsets.zero),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
                              uploadInput.click();
                              uploadInput.onChange.listen((event) {
                                final html.File file = uploadInput.files!.first!;
                                setState(() {
                                  _audio = file;
                                });
                              });
                            },
                            child: Text('Choose Audio'),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: uploadAudio,
                            child: Text('Upload Audio'),
                          ),
                          Row(
                            children: [
                              image == null
                                  ? Container()
                                  : TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    SaveDatatoFirebase();
                                  }
                                },
                                child: Text("Save"),
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Colors.cyan)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    clean();
                                  },
                                  child: Text("Cancel"),
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(Colors.cyan))),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
