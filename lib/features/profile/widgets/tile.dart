import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final Color backgroundColor;
  final Color forgroundColor;
  final String label;
  final VoidCallback? onTap;

  const Tile({
    super.key,
    this.backgroundColor = DarkColors.gray,
    this.forgroundColor = kBlackColor,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: backgroundColor,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: forgroundColor,
          ),
        ),
      ),
    );
  }
}
