import 'package:flame/core/common/widgets/button.dart';
import 'package:flutter/material.dart';

class NoUserFound extends StatelessWidget {
  final VoidCallback onRefreshTap;

  const NoUserFound({super.key, required this.onRefreshTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "No More Users Found",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Button(
          text: "Refresh",
          onTap: onRefreshTap,
        ),
      ],
    );
  }
}
