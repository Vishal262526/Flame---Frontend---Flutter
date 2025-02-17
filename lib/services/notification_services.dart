import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  static final notificationPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  static Future<String?> getFcmToken() => FirebaseMessaging.instance.getToken();

  static Future<bool> requestNotificationPermission() async {
    final status = await FirebaseMessaging.instance.requestPermission();

    if (status.authorizationStatus == AuthorizationStatus.authorized) {
      return true;
    } else {
      return false;
    }
  }

  AndroidNotificationChannel _notificationChannel() {
    final channel = AndroidNotificationChannel(
      "flame_custom_channel_id", "flame_custom_channel",
      description: "Daily Notification Channel",
      importance: Importance.max, // High importance for pop-ups and sound
      playSound: true,
      sound: RawResourceAndroidNotificationSound("notification_sound"),
    );
    return channel;
  }

  static NotificationDetails notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "flame_custom_channel_id",
        "flame_custom_channel",
        channelDescription: "Daily Notification Channel",
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound("notification_sound"),
      ),
    );
  }

  Future<void> initNotification() async {
    if (_isInitialized) {
      print("Notification is not initialized ......");
      return;
    }

    final initSettingsAndroid =
        AndroidInitializationSettings("@drawable/ic_stat_logo_solid");

    final initSettings = InitializationSettings(android: initSettingsAndroid);

    try {
      // await notificationPlugin
      //     .resolvePlatformSpecificImplementation<
      //         AndroidFlutterLocalNotificationsPlugin>()
      //     ?.createNotificationChannel(_notificationChannel());

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
    notificationPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }
}
