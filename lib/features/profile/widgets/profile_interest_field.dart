import 'package:flame/core/common/enums/gender_enum.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/features/profile/widgets/tile.dart';
import 'package:flutter/material.dart';

class ProfileInterestField extends StatelessWidget {
  final String label;
  final Function(Gender) onChange;
  final Gender selectedGender;

  const ProfileInterestField({
    super.key,
    required this.label,
    required this.onChange,
    required this.selectedGender,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: DarkColors.primary,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Tile(
          backgroundColor: selectedGender == Gender.male
              ? DarkColors.primary
              : DarkColors.gray,
          forgroundColor:
              selectedGender == Gender.male ? kWhiteColor : kBlackColor,
          label: "Male",
          onTap: () {
            onChange(Gender.male);
          },
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
