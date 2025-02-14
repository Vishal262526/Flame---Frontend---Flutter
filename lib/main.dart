import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flame/core/config/supabase_config.dart';
import 'package:flame/core/routes/routes.dart';
import 'package:flame/core/routes/routes_name.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/core/theme/app_theme.dart';
import 'package:flame/features/auth/controller/auth_controller.dart';
import 'package:flame/features/friends/controllers/friend_controller.dart';
import 'package:flame/features/profile/controller/profile_controller.dart';
import 'package:flame/features/profile/controller/user_profile_controller.dart';
import 'package:flame/features/users/controllers/navigation_controller.dart';
import 'package:flame/features/users/controllers/user_controller.dart';
import 'package:flame/firebase_options.dart';
import 'package:flame/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundNotification(RemoteMessage message) async {
  (message) async {
    print("Background Notification Received");
    print("Background notification received...........");
    NotificationServices.showNotification(
      id: DateTime.now().second,
      title: message.notification?.title ?? "",
      body: message.notification?.body ?? "",
    );
  };
}

void main() async {
  // Ensure everything is init perfectly then after the app
  WidgetsFlutterBinding.ensureInitialized();

  // Init Firebase (only for notification)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationServices().initNotification();

  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );

  // Change status bar or bottom navigation bar colors (top and bottom screen edges)
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: DarkColors.border1, // navigation bar color
    statusBarColor: DarkColors.border1, // status bar color
  ));

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.lazyPut(() => NavigationController());
        Get.lazyPut(() => FriendController());
        Get.lazyPut(() => UsersController());
        Get.lazyPut(() => UserProfileController());
        Get.lazyPut(() => ProfileController());
      }),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: RoutesName.home,
      getPages: Routes.pages,
    );
  }
}
