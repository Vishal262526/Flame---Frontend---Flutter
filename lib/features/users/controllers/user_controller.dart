import 'package:flame/core/common/models/user_model.dart';
import 'package:flame/core/utils/app_utils.dart';
import 'package:flame/features/users/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  final _userRepositroy = UsersRepository();

  final noMoreUsers = false.obs;

  final controller = PageController(initialPage: 0);

  // Loadings
  final isLoading = false.obs;
  final actionProcessing = false.obs;

  final users = <UserModel>[].obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    loadUser();
  }

  void loadUser() async {
    isLoading.value = true;

    final res = await _userRepositroy.loadUserProfiles();

    res.fold(
      (failure) {
        AppUtils.showSnackBar(title: "Error", message: failure.message);
      },
      (usersList) {
        users.value = usersList;
      },
    );
    isLoading.value = false;
  }
}
