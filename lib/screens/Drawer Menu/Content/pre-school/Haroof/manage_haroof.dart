import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:html' as html;
import '../../../../../controllers/authServices.dart';

class ManageHaroof extends StatefulWidget {
  @override
  State<ManageHaroof> createState() => _ManageHaroofState();
}

class _ManageHaroofState extends State<ManageHaroof> {
  //const ManageHaroof({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  FirebaseServices _services = FirebaseServices();
  html.File? video;
  final TextEditingController _harfName = TextEditingController();
  dynamic image;
  String? fileName;
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<String> uploadVideo(html.File file) async {
    final String fileName = '${DateTime.now().millisecondsSinceEpoch}.mp4';
    final Reference ref = storage.ref().child('videos/$fileName');
    final UploadTask task = ref.putBlob(file);
    final TaskSnapshot snapshot = await task.whenComplete(() {});
    final String url = await snapshot.ref.getDownloadURL();
    return url;
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
      _harfName.clear();
      image == null;
      video == null;
    });
  }

  void _openFileExplorer() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((event) {

      final html.File file = uploadInput.files!.first!;
      setState(() {
        video = file;
      });
    });
  }

  SaveDatatoFirebase() async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('gs://speatalladmin.appspot.com/HaroofImages/$fileName');
    EasyLoading.show(status: "Loading");
    try {
      await ref.putData(image); //upload image to cloud
      if (video == null) {
        return;
      }
      String url = await uploadVideo(video!);

      String downloadURL = await ref.getDownloadURL().then((value) {
        if (value.isNotEmpty) {
          _services.SaveHaroof(
                  reference: _services.Haroof,
                  data: {
                    'HaroofName': _harfName.text,
                    'image': value,
                    'video': url
                  },
                  docName: _harfName.text)
              .then((value) {
            EasyLoading.dismiss();
            clean();
          });
        }
        return value;
      }); //get downlaad lonk
    } on firebase_core.FirebaseException catch (e) {
      print(e.toString());
      clean();
      EasyLoading.dismiss();
    }
  }
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    String videoName = video != null ? video!.name : "No file selected";
    return SingleChildScrollView(
      child: SingleChildScrollView(
        controller: _controller,
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
                  "Add Harf",
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
                      ElevatedButton(
                        onPressed: _openFileExplorer,
                        child: Text('Choose Video'),
                      ),
                      SizedBox(height: 10),
                      Text(videoName),
                      Column(
                        children: [
                          Container(
                            width: 200,
                            child: TextFormField(
                              controller: _harfName,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  label: Text(
                                    "Enter Harf Name",
                                    style: TextStyle(fontFamily: 'Noori'),
                                  ),
                                  contentPadding: EdgeInsets.zero),
                            ),
                          ),
                          Row(
                            children: [
                              image == null &&
                              video == null
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
                                  onPressed: () {},
                                  child: Text("Cencel"),
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
