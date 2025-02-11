import 'package:flame/features/flames/pages/flames_page.dart';
import 'package:flame/features/profile/pages/friend_profile_page.dart';
import 'package:flame/features/profile/pages/my_profile_page.dart';
import 'package:flame/kayout/bottom_nav.dart';
import 'package:flame/core/routes/routes_name.dart';
import 'package:flame/core/splash/splash_screen.dart';
import 'package:flame/features/auth/views/login_view.dart';
import 'package:flame/features/chats/pages/chat_inbox_page.dart';
import 'package:flame/features/friends/pages/friends_page.dart';
import 'package:flame/features/profile/pages/update_profile_page.dart';
import 'package:flame/features/profile/pages/user_profile_page.dart';
import 'package:get/get.dart';

class Routes {
  static final pages = [
    GetPage(
      name: RoutesName.home,
      page: () => const SplashScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RoutesName.requests,
      page: () => const FriendsPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RoutesName.login,
      page: () => LoginView(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RoutesName.updateProfile,
      page: () => UpdateProfilePage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RoutesName.mainLayout,
      page: () => MainLayout(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: RoutesName.chatInbox,
      page: () => ChatInboxPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RoutesName.userProfile,
      page: () => UserProfilePage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RoutesName.myProfile,
      page: () => MyProfilePage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RoutesName.friendProfile,
      page: () => FriendProfilePage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RoutesName.flames,
      page: () => FlamesPage(),
      transition: Transition.rightToLeft,
    ),
  ];
}
