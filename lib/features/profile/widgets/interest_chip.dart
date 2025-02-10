import 'package:flutter/material.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/features/profile/models/interest_model.dart';

class InterestChip extends StatelessWidget {
  final InterestModel interest;
  final Function(InterestModel interestData) onTap;
  final bool isSelected;

  const InterestChip({
    super.key,
    required this.interest,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(interest);
      },
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
            border: isSelected ? Border.all(color: kWhiteColor) : null,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(8.0),
          child: Text(
            interest.name,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
