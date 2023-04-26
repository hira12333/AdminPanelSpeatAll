import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:html' as html;

import 'package:firebase_storage/firebase_storage.dart';
class FirebaseServices{
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  FirebaseFirestore firestore  = FirebaseFirestore.instance;
  CollectionReference Haroof = FirebaseFirestore.instance.collection('Haroof');
  CollectionReference counting = FirebaseFirestore.instance.collection('Ginti');

Future<void> SaveHaroof({ required CollectionReference reference, required Map<String, dynamic>data, required String docName }) async {

  return reference.doc(docName).set(data);

}
  Future<void> SaveGinti({ required CollectionReference reference, required Map<String, dynamic>data, required String numberName }) async {

    return reference.doc(numberName).set(data);

  }
}