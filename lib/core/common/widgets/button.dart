import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Widget? icon;
  final VoidCallback? onTap;
  final bool fullWidth;
  final bool isDisabled;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const Button({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    this.fullWidth = false,
    this.isDisabled = false,
    this.backgroundColor = DarkColors.primary,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton.icon(
        icon: icon,
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: backgroundColor,
          textStyle: textStyle,
        ),
        onPressed: isDisabled ? null : onTap,
        label: Text(text),
      ),
    );
  }
}
