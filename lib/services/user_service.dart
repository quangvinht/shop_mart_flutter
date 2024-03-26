import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_mart/models/user_model.dart';
import 'package:shop_mart/services/notification_service.dart';

class UserService {
  static Future<void> createUser(String email, String password, String name,
      String uid, String userImageurl) async {
    final token = await NotificationsFirebaseService.initNotifications();

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'id': uid,
      'name': name.trim(),
      'image': userImageurl,
      'email': email.trim().toLowerCase(),
      'createdAt': Timestamp.now(),
      'token': token,
      'Wish': [],
      'Cart': [],
    });
  }

  static Future<UserModel> getUser(
    String uid,
  ) async {
    final token = await NotificationsFirebaseService.initNotifications();

    final userDoc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    final userDocDict = userDoc.data();
    final user = UserModel(
      userId: userDoc.get("id"),
      token: userDoc.get("token"),
      userName: userDoc.get("name"),
      userImage: userDoc.get("image"),
      userEmail: userDoc.get('email'),
      userCart: userDocDict!.containsKey("Cart") ? userDoc.get("Cart") : [],
      userWish: userDocDict.containsKey("Wish") ? userDoc.get("Wish") : [],
      userViewed:
          userDocDict.containsKey("Viewed") ? userDoc.get("Viewed") : [],
      createdAt: userDoc.get('createdAt'),
    );

    if (user.token != token) {
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        'token': token,
      });
    }

    return user;
  }
}
