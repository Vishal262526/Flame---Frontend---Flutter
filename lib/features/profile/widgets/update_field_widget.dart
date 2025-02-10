import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flame/core/common/widgets/button.dart';
import 'package:flame/core/theme/app_colors.dart';

class UpdateFieldWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final String nextBUttonText;
  final bool showBackButton;
  final VoidCallback? onNextTap;
  final VoidCallback? onBackTap;
  final String? errorMessage;

  const UpdateFieldWidget({
    super.key,
    required this.title,
    required this.child,
    this.nextBUttonText = "Next",
    this.showBackButton = true,
    required this.onNextTap,
    required this.onBackTap,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: Get.width / 1.3,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kWhiteColor,
                    ),
                  ),
                  if (errorMessage != null)
                    const SizedBox(
                      height: 20,
                    ),
                  if (errorMessage != null)
                    Text(
                      errorMessage ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                      ),
                    ),
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(child: child),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                if (showBackButton)
                  Expanded(
                    child: Button(
                      backgroundColor: DarkColors.secondary,
                      fullWidth: true,
                      text: "Back",
                      onTap: onBackTap,
                    ),
                  ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Button(
                    fullWidth: true,
                    text: nextBUttonText,
                    onTap: onNextTap,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
