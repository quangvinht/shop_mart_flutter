import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleOnBackgroundMessage(RemoteMessage? message) async {
  print('message:${message!.notification!.title}');
}

void handleMessage(RemoteMessage? message) {
  if (message == null) return;
}

class NotificationsFirebaseService {
  static Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

    await FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(
      handleOnBackgroundMessage,
    );
  }

  static Future<String> initNotifications() async {
    await FirebaseMessaging.instance.requestPermission();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    //print('fcmToken' + fcmToken.toString());
    // FirebaseMessaging.onBackgroundMessage(
    //   handleOnBackgroundMessage,
    // );
    initPushNotifications();

    return fcmToken.toString();
  }
}
