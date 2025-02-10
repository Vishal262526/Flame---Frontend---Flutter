import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  final String text;
  final Widget? icon;
  final VoidCallback? onTap;
  final bool fullWidth;
  final bool isDisabled;
  final Color color;

  const OutlineButton({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    this.fullWidth = false,
    this.isDisabled = false,
    this.color = DarkColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: color),
          ),
        ),
        onPressed: isDisabled ? null : onTap,
        child: Wrap(
          spacing: 16,
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (icon != null) icon!,
            Text(text),
          ],
        ),
      ),
    );
  }
}
