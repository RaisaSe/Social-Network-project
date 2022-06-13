import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late final String email;
  late final String uid;
  late final String photoUrl;
  late final String username;
  late final String bio;
  late final List<String> followers;
  late final List<String> following;

  User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });

  User.fromSnap(DocumentSnapshot<Map<String, dynamic>> snap) {
    // var snapshot = snap.data() as Map<String, dynamic>;
    // return User(

    username = (snap.data()!["username"] as String);
    uid = (snap.data()!["uid"] as String);
    email = (snap.data()!["email"] as String);
    photoUrl = (snap.data()!["photoUrl"] as String);
    bio = (snap.data()!["bio"] as String);
    followers = (snap.data()!["followers"] as List<String>);
    following = (snap.data()!["following"] as List<String>);
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
