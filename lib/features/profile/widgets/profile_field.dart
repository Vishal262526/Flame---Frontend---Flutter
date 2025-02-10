import 'package:flame/core/common/widgets/input.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final String label;
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool readOnly;
  final String? errorText;

  const ProfileField({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.label,
    required this.onSubmit,
    required this.onBack,
    this.validator,
    this.onTap,
    this.readOnly = false,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
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
                Input(
                  onTap: onTap,
                  readOnly: readOnly,
                  validator: validator,
                  controller: controller,
                  placeholder: placeholder,
                  isCenter: true,
                ),
                if (errorText != null)
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: Text(
                      errorText!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                      ),
                    ),
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
