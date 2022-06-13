import 'dart:typed_data' show Uint8List;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_network/models/user.dart' as model;
import 'package:social_network/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _firestore.collection('user').doc(currentUser.uid).get();

    print('documentSnapshot: $documentSnapshot');

    return model.User.fromSnap(documentSnapshot);
  }

  //sign up the user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List? file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register the user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePictures', file!, false);

        //adding user to our database

        model.User _user = model.User(
          bio: bio,
          username: username,
          uid: cred.user!.uid,
          email: email,
          photoUrl: photoUrl,
          following: [],
          followers: [],
        );

        await _firestore.collection("users").doc(cred.user!.uid).set(
              _user.toJson(),
            );
        res = "Succes";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// logging the user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Succes";
      } else {
        res = "Please enter all the fields required";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
