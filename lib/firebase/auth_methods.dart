
import 'dart:typed_data';
// import 'package:slogin/models/users.dart' ;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:speatall_admin/firebase/storage_methods.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  //signup user
  Future<String> SignupUser({
    required String email,
    required String password,
    required String username,
    required Uint8List file,
  }) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        //add user to db

       await _firestore.collection('users').doc(cred.user!.uid).set({
         'username': username,
         'uid' : cred.user!.uid,
         'email' : email,
         'photoUrl' : photoUrl,
       });

        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted.';
      } else if (err.code == 'weak-password') {
        res = 'Password should be of at least 6 letters';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //loging in user
  Future<String> loginUser({required String email, required String password})
  async {
    String res = "Your email or password is badly formatted";
    try{
      if(email.isNotEmpty|| password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";
      }else if (email.isEmpty || password.isEmpty)
      {
        res="please enter all the feilds";
      }
    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        res = "user not found";
      }
      else if(e.code == 'wrong-password'){
        res = " wrong pass";
      }
    }
    catch(err){
      res= err.toString();
    }
    return res;
  }
}
