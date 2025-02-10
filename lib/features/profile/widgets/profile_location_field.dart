import 'package:flame/core/common/widgets/button.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ProfileLocationField extends StatelessWidget {
  final VoidCallback onTap;
  final Position? currentLocation;
  final bool isProcessing;

  const ProfileLocationField({
    super.key,
    required this.currentLocation,
    required this.onTap,
    this.isProcessing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const FaIcon(
          FontAwesomeIcons.locationDot,
          size: 100,
          color: DarkColors.gray,
        ),
        const SizedBox(
          height: 50,
        ),
        if (isProcessing) const CircularProgressIndicator(),
        if (currentLocation != null)
          const Text(
            "Location successfully updated, click finish to update your profile",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: DarkColors.gray,
            ),
          ),
        if (!isProcessing && currentLocation == null)
          Button(
            text: "Get Current Location",
            onTap: onTap,
            backgroundColor: DarkColors.backgroundLight,
          ),
      ],
    );
  }
}
