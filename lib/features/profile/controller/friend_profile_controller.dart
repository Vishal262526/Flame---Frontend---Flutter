import 'package:flame/core/utils/app_utils.dart';
import 'package:flame/features/friends/models/friend_profile_model.dart';
import 'package:flame/features/profile/repository/profile_repository.dart';
import 'package:get/get.dart';

class FriendProfileController extends GetxController {
  final _profileRepository = ProfileRepository();

  final isLoading = false.obs;
  final profile = Rx<FriendProfileModel?>(null);

  void loadFriendProfile({required String friendId}) async {
    isLoading.value = true;
    final res = await _profileRepository.getFriendProfile(friendId: friendId);

    res.fold(
      (failure) {
        AppUtils.showSnackBar(title: "Error", message: failure.message);
      },
      (friendProfile) {
        profile.value = friendProfile;
      },
    );
    isLoading.value = false;
  }
}
