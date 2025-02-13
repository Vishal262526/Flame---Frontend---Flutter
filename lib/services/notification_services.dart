import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class NotificationServices {
  static final notificationPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  static Future<String?> getFcmToken() => FirebaseMessaging.instance.getToken();

  static Future<NotificationSettings> requestNotificationPermission() =>
      FirebaseMessaging.instance.requestPermission();

  static NotificationDetails notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "notification_id",
        "notification",
        channelDescription: "Daily Notification Channel",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  Future<void> initNotification() async {
    if (_isInitialized) {
      print("Notification is not initialized ......");
      return;
    }

    final initSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    final initSettings = InitializationSettings(android: initSettingsAndroid);

    try {
      await notificationPlugin.initialize(initSettings);
    } catch (e) {
      print("Error During local notification initialization .........");
      print(e);
    }
  }

  static Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }
}
