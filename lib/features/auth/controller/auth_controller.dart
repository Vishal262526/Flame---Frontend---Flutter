import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flame/core/common/models/user_model.dart';
import 'package:flame/core/routes/routes_name.dart';
import 'package:flame/core/utils/app_utils.dart';
import 'package:flame/main.dart';
import 'package:flame/services/notification_services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flame/features/auth/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  // States
  final isLoading = false.obs;

  // Repositories
  final _authRepostiory = AuthRepository();
  final user = Rx<User?>(null);

  final myProfile = Rx<CurrentUserModel?>(null);

  StreamSubscription? notificationRefreshStream;
  StreamSubscription? notificationForgoundMessageStream;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    print("Event listener is running");

    Supabase.instance.client.auth.onAuthStateChange.listen(
      (authState) async {
        if (authState.session == null) {
          print("User is not logged  in .....");
          Get.offAllNamed(RoutesName.login);
          FlutterNativeSplash.remove();
        } else {
          print("User is logged  in .....");
          user.value = authState.session?.user;
          await initUserProfile();
        }
      },
    );
  }

  Future<void> initUserProfile() async {
    final res = await _authRepostiory.getMyProfile();

    res.fold(
      (failure) {
        AppUtils.showSnackBar(title: "Error", message: failure.message);
      },
      (profileData) async {
        if (profileData == null) {
          Get.offAllNamed(RoutesName.updateProfile);
          FlutterNativeSplash.remove();
        } else {
          myProfile.value = profileData;

          Get.offAllNamed(RoutesName.mainLayout);

          FlutterNativeSplash.remove();

          try {
            // Request Notification Permission
            await NotificationServices.requestNotificationPermission();

            notificationRefreshStream?.cancel();
            notificationForgoundMessageStream?.cancel();

            // Get the FCM Token
            final fcmToken = await NotificationServices.getFcmToken();

            if (fcmToken != null) {
              if (fcmToken != profileData.fcmToken) {
                print("FCM token is updateing .......");
                await _authRepostiory.updateFCMToken(fmcToken: fcmToken);
              } else {
                print("FCM token is not updateing .......");
              }
            }

            notificationRefreshStream =
                FirebaseMessaging.instance.onTokenRefresh.listen(
              (newFcmToken) async {
                await _authRepostiory.updateFCMToken(fmcToken: newFcmToken);
              },
            );

            FirebaseMessaging.onMessage.listen(
              (message) async {
                print("Forgound Notification is received ........");
                await NotificationServices.showNotification(
                  id: DateTime.now().second,
                  title: message.notification?.title ?? "",
                  body: message.notification?.body ?? "",
                );
              },
            );

            FirebaseMessaging.onBackgroundMessage(
              handleBackgroundNotification,
            );
          } catch (e) {
            print("Something is wrong with this auth controller .......");
            print(e);
            Get.offAllNamed(RoutesName.login);
          }
        }
      },
    );
  }

  void signOut() async {
    final res = await _authRepostiory.singOut();

    res.fold(
      (failure) {
        AppUtils.showSnackBar(title: "Error", message: failure.message);
      },
      (_) {
        user.value = null;
        myProfile.value = null;
      },
    );
  }

  void connectWithGoogle() async {
    final res = await _authRepostiory.signInWithGoogle();

    res.fold(
      (failure) {
        AppUtils.showSnackBar(title: "Error", message: failure.message);
      },
      (userCred) {},
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    notificationRefreshStream?.cancel();
    notificationForgoundMessageStream?.cancel();
    super.dispose();
  }
}
