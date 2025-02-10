import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String profileUrl;
  final Function(String name) onTap;

  const ChatUserCard({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.profileUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap(name);
      },
      leading: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: DarkColors.border2,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(lastMessage),
    );
  }
}
