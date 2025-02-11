import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  static Future<String?> getFcmToken() => FirebaseMessaging.instance.getToken();

  static Future<NotificationSettings> requestNotificationPermission() =>
      FirebaseMessaging.instance.requestPermission();
}
