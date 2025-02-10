import 'dart:io';

import 'package:flame/features/profile/widgets/upload_image_card.dart';
import 'package:flutter/material.dart';

class ProfileImagesField extends StatelessWidget {
  final VoidCallback onTap;

  final List<File> images;
  final Function(int index) onRemove;

  const ProfileImagesField({
    super.key,
    required this.onTap,
    required this.images,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      children: [
        GestureDetector(
          onTap: images.isNotEmpty ? null : onTap,
          child: UploadImageCard(
            image: images.isNotEmpty ? images[0] : null,
            onRemove: () {
              onRemove(0);
            },
          ),
        ),
        GestureDetector(
          onTap: images.length >= 2 ? null : onTap,
          child: UploadImageCard(
            image: images.length >= 2 ? images[1] : null,
            onRemove: () {
              onRemove(1);
            },
          ),
        ),
        GestureDetector(
          onTap: images.length >= 3 ? null : onTap,
          child: UploadImageCard(
            image: images.length >= 3 ? images[2] : null,
            onRemove: () {
              onRemove(2);
            },
          ),
        ),
        GestureDetector(
          onTap: images.length >= 4 ? null : onTap,
          child: UploadImageCard(
            onRemove: () {
              onRemove(3);
            },
            image: images.length >= 4 ? images[3] : null,
          ),
        ),
      ],
    );
  }
}
