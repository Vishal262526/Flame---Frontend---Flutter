import 'dart:io';

import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UploadImageCard extends StatelessWidget {
  final File? image;
  final VoidCallback onRemove;

  const UploadImageCard({
    super.key,
    required this.image,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: image != null
              ? null
              : Border.all(
                  width: 2,
                  color: DarkColors.border2,
                ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            image != null
                ? Image.file(
                    image!,
                    fit: BoxFit.cover,
                  )
                : const Center(
                    child: FaIcon(
                      FontAwesomeIcons.image,
                      color: DarkColors.gray,
                    ),
                  ),
            if (image != null)
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: onRemove,
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: DarkColors.primary,
                    child: Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
              )
          ],
        ));
  }
}
