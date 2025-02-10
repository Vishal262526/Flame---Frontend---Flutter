import 'package:flame/core/common/models/user_model.dart';
import 'package:flame/core/utils/app_utils.dart';
import 'package:flame/features/profile/repository/profile_repository.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  final _profileRepository = ProfileRepository();

  final isLoading = false.obs;
  final user = Rx<UserModel?>(null);

  void loadUserProfile({required String userId}) async {
    print("User id is .......$userId");
    isLoading.value = true;
    final res = await _profileRepository.getUserProfile(userId: userId);

    res.fold(
      (failure) {
        AppUtils.showSnackBar(title: "Error", message: failure.message);
      },
      (userProfile) {
        user.value = userProfile;
      },
    );
    isLoading.value = false;
  }
}
