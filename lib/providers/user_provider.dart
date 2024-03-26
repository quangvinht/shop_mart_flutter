import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_mart/consts/firebase_error.dart';
import 'package:shop_mart/models/user_model.dart';
import 'package:shop_mart/services/user_service.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;
  UserModel? get getUserModel {
    return userModel;
  }

  Future<UserModel?> fetchUserInfo() async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return null;
    }
    String uid = user.uid;
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      final userDocDict = userDoc.data();
      userModel = await UserService.getUser(uid);
      notifyListeners();
      return userModel;
    } on FirebaseException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
