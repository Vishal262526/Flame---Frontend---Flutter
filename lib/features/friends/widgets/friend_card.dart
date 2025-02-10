import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/features/friends/models/friend_model.dart';
import 'package:flutter/material.dart';

class FriendCard extends StatelessWidget {
  final VoidCallback onTap;
  final FriendModel friend;

  const FriendCard({
    super.key,
    required this.onTap,
    required this.friend,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      leading: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(friend.images[0]),
            fit: BoxFit.cover,
          ),
          color: DarkColors.border2,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      title: Text(
        friend.name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      // subtitle: Text(friend.city),
    );
  }
}
