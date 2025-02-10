import 'package:cached_network_image/cached_network_image.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/features/friends/models/friend_request_model.dart';
import 'package:flutter/material.dart';

class ReceivedRequestCard extends StatelessWidget {
  final Function(FriendRequestModel request) onAccepted;
  final bool disabled;
  final FriendRequestModel user;

  const ReceivedRequestCard({
    super.key,
    required this.onAccepted,
    required this.user,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      leading: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              user.images[0],
            ),
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
      subtitle: Text(user.city),
      trailing: GestureDetector(
        onTap: disabled
            ? null
            : () {
                onAccepted(user);
              },
        child: const CircleAvatar(
          backgroundColor: DarkColors.border2,
          radius: 25,
          child: Icon(Icons.done),
        ),
      ),
    );
  }
}
