import 'package:flame/core/common/enums/gender_enum.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/features/profile/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileShowMeField extends StatelessWidget {
  final String label;
  final Gender currentValue;
  final Function(Gender gender) onChanged;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  const ProfileShowMeField({
    super.key,
    required this.currentValue,
    required this.onChanged,
    required this.label,
    required this.onSubmit,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          IconButton(
            style: IconButton.styleFrom(backgroundColor: DarkColors.border1),
            onPressed: onBack,
            icon: const FaIcon(Icons.arrow_back),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: kWhiteColor,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 7,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tile(
                  backgroundColor: currentValue == Gender.male
                      ? DarkColors.border2
                      : DarkColors.border1,
                  forgroundColor: kWhiteColor,
                  label: "Male",
                  onTap: () {
                    onChanged(Gender.male);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Tile(
                  backgroundColor: currentValue == Gender.female
                      ? DarkColors.border2
                      : DarkColors.border1,
                  forgroundColor: kWhiteColor,
                  label: "Female",
                  onTap: () {
                    onChanged(Gender.female);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Tile(
                  backgroundColor: currentValue == Gender.other
                      ? DarkColors.border2
                      : DarkColors.border1,
                  forgroundColor: kWhiteColor,
                  label: "Others",
                  onTap: () {
                    onChanged(Gender.other);
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onSubmit,
        child: const FaIcon(Icons.arrow_forward),
      ),
    );
  }
}
