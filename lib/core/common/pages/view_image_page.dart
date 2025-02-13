import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewImagePage extends StatelessWidget {
  const ViewImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl = Get.arguments as String;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(
              8.0,
            ),
            child: CircleAvatar(
              backgroundColor: kWhiteColor,
              child: Icon(
                Icons.arrow_back,
                color: kBlackColor,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: EasyImageView(
        doubleTapZoomable: true,
        maxScale: 2.5,
        minScale: 1,
        imageProvider: CachedNetworkImageProvider(imageUrl),
      ),
    );
  }
}
