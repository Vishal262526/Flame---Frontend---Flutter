import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController? controller;
  final String placeholder;
  final String? label;
  final bool isCenter;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool readOnly;
  final Icon? icon;
  final String? errorText;
  final Icon? suffixIcon;

  final Function(String value)? onChanged;

  const Input({
    super.key,
    this.controller,
    required this.placeholder,
    this.label,
    this.isCenter = false,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.icon,
    this.errorText,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onChanged: onChanged,
      onTap: onTap,
      style: const TextStyle(color: kWhiteColor, fontSize: 20),
      validator: validator,
      textAlign: isCenter ? TextAlign.center : TextAlign.start,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: icon,
        hintText: placeholder,
        label: label != null
            ? Text(
                label!,
              )
            : null,
      ),
    );
  }
}
