import 'package:flame/core/common/enums/gender_enum.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/features/profile/widgets/tile.dart';
import 'package:flutter/material.dart';

class ProfileGenderField extends StatelessWidget {
  final Function(Gender) onChange;
  final Gender selectedGender;

  const ProfileGenderField({
    super.key,
    required this.onChange,
    required this.selectedGender,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tile(
          backgroundColor: selectedGender == Gender.male
              ? DarkColors.primary
              : DarkColors.border1,
          forgroundColor: kWhiteColor,
          label: "Male",
          onTap: () {
            onChange(Gender.male);
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Tile(
          backgroundColor: selectedGender == Gender.female
              ? DarkColors.primary
              : DarkColors.border1,
          forgroundColor: kWhiteColor,
          label: "Female",
          onTap: () {
            onChange(Gender.female);
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Tile(
          backgroundColor: selectedGender == Gender.other
              ? DarkColors.primary
              : DarkColors.border1,
          forgroundColor: kWhiteColor,
          label: "Others",
          onTap: () {
            onChange(Gender.other);
          },
        )
      ],
    );
  }
}
