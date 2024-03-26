import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shop_mart/services/user_service.dart';

class AuthService {
  static Future<void> createUserWithEmailAndPassword(
      String email, String password, String name, String path) async {
    final auth = FirebaseAuth.instance;

    await auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    final User? user = auth.currentUser;
    final ref =
        FirebaseStorage.instance.ref().child('userImage').child('$email.jpg');
    await ref.putFile(File(path));
    final userImageurl = await ref.getDownloadURL();

    await UserService.createUser(
        email, password, name, user!.uid, userImageurl);
  }

  static Future<void> signOut() async {
    final auth = FirebaseAuth.instance;
    await auth.signOut();
  }

  static Future<void> resetpassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
