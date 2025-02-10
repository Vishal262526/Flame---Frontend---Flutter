import 'package:flame/features/profile/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';

class ProfileMenuBottomSheet extends StatelessWidget {
  const ProfileMenuBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProfileMenuItem(text: "Edit Profile", icon: Icons.person),
        ProfileMenuItem(text: "Account Settings", icon: Icons.account_box),
        ProfileMenuItem(text: "Settings", icon: Icons.settings),
        ProfileMenuItem(text: "Log Out", icon: Icons.logout),
      ],
    );
  }
}
