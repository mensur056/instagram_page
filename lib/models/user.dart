import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String userName;
  final String uid;
  final String photoUrl;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.bio,
    required this.email,
    required this.uid,
    required this.userName,
    required this.photoUrl,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'uid': uid,
        'email': email,
        'bio': bio,
        'followers': followers,
        'following': following,
        'photoUrl': photoUrl,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
  }
}
