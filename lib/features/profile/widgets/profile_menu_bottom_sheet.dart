import 'package:flame/features/profile/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';

class ProfileMenuBottomSheet extends StatelessWidget {
  final VoidCallback? onLogoutTap;
  const ProfileMenuBottomSheet({
    super.key,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileMenuItem(
            text: "Edit Profile",
            icon: Icons.person,
          ),
          ProfileMenuItem(
            text: "Account Settings",
            icon: Icons.account_box,
          ),
          ProfileMenuItem(
            text: "Settings",
            icon: Icons.settings,
          ),
          ProfileMenuItem(
            onTap: onLogoutTap,
            text: "Log Out",
            icon: Icons.logout,
          ),
        ],
      ),
    );
  }
}
