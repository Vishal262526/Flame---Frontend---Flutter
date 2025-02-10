import 'dart:io';

import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AppUtils {
  static void showToast({
    required String message,
  }) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: DarkColors.border1,
      textColor: kWhiteColor,
    );
  }

  static void showSnackBar({
    required String title,
    required String message,
    Color backgroundColor = Colors.redAccent,
    Color textColor = kWhiteColor,
  }) {
    Get.snackbar(
      title,
      message,
      colorText: textColor,
      backgroundColor: backgroundColor,
    );
  }

  static Future<File?> pickImage({
    required ImageSource imageSource,
  }) async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: imageSource,
    );

    return pickedImage != null ? File(pickedImage.path) : null;
  }

  static Future<List<File>> pickMultipleImages() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickMultiImage(
      limit: 4,
    );

    return pickedImage.map((image) => File(image.path)).toList();
  }
}

String generateGeographyPoint(double lat, double lng) =>
    'SRID=4326;POINT($lng $lat)';
