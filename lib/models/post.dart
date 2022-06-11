import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      username: snapshot["username"],
      uid: snapshot["uid"],
      likes: snapshot["likes"],
      description: snapshot["description"],
      postUrl: snapshot["postUrl"],
      datePublished: snapshot["datePublished"],
      profileImage: snapshot["profileImage"],
      postId: snapshot["postId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "description": description,
        "postId": postId,
        "postUrl": postUrl,
        "datePublished": datePublished,
        "profileImage": profileImage,
        "likes": likes,
      };
}
