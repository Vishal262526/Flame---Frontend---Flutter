import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/features/friends/models/friend_request_model.dart';
import 'package:flutter/material.dart';

class SentRequestCard extends StatelessWidget {
  final FriendRequestModel user;

  const SentRequestCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      leading: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(user.images[0]),
            fit: BoxFit.cover,
          ),
          color: DarkColors.border2,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      title: Text(
        user.name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      // subtitle: Text("Age ${user.city}"),
    );
  }
}
