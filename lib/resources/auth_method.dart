import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth/auth_log_in_page.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<User?> get authChange => auth.authStateChanges();
  signOut(BuildContext context) {
    auth.signOut().whenComplete(() => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LogInWithGoogle())));
  }

  Future<bool> signInwithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          firestore.collection('users').doc(user.uid).set({
            'userName': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
          });
        }
        return true;
      }
    } on FirebaseAuthException catch (e) {
      showSnakBar(context, e.message!);
      res = false;
    }
    return res;
  }

  Future<String?> getPhotoUrl(String uid) async {
    DocumentSnapshot snapshot =
        await firestore.collection('users').doc(uid).get();
    if (snapshot.exists) {
      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;
      if (userData != null) {
        return userData['profilePhoto'] as String?;
      }
    }
    return null;
  }
}

showSnakBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}
