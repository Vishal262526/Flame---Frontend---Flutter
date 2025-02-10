import 'package:flame/features/friends/pages/friends_page.dart';
import 'package:flame/features/profile/pages/profile_page.dart';
import 'package:flame/features/users/pages/match_page.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  // States
  final selectedIndex = 0.obs;

  final pages = [
    const MatchPage(),
    const FriendsPage(),
    const ProfilePage(),
  ];

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
