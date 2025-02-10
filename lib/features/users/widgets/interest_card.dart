import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InterestCard extends StatelessWidget {
  final String text;

  const InterestCard({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      color: kWhiteColor.withOpacity(0.1),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
