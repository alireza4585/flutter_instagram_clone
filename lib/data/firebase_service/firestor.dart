import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_instagram_clone/util/exeption.dart';

class Firestor_firebase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser({
    required String email,
    required String username,
    required String bio,
    required String profileImage,
  }) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({
        'email': email,
        'username': username,
        'bio': bio,
        'profileImage': profileImage,
        'followers': [],
        'following': [],
      });
      return true;
    } on FirebaseException catch (e) {
      throw exceptions(e.message.toString());
    }
  }
}
