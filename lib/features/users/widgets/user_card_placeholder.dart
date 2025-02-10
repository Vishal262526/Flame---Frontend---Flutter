import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserCardPlaceholder extends StatelessWidget {
  const UserCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        enabled: true,
        child: Container(
          color: DarkColors.border2,
          width: double.infinity,
          height: double.infinity,
        ));
  }
}
