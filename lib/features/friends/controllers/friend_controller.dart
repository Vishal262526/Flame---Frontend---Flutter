import 'package:flame/core/utils/app_utils.dart';
import 'package:flame/features/auth/controller/auth_controller.dart';
import 'package:flame/features/friends/models/friend_model.dart';
import 'package:flame/features/friends/models/friend_profile_model.dart';
import 'package:flame/features/friends/models/friend_request_model.dart';
import 'package:flame/features/friends/repository/friend_repository.dart';
import 'package:flame/features/users/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class FriendController extends GetxController {
  final _friendRepository = FriendRepository();

  // Friend Profile
  final isLoading = false.obs;
  final friendProfile = Rx<FriendProfileModel?>(null);

  // Friends
  final friendsLoading = false.obs;
  final friendsList = RxList<FriendModel>([]);

  // Friends Requests
  final receivedRequestsLoading = false.obs;
  final receivedRequestsList = RxList<FriendRequestModel>([]);

  // final sentRequestsLoading = false.obs;
  // final sentRequestsList = RxList<FriendRequestModel>([]);

  final actionProcessing = false.obs;

  final _userController = Get.find<UsersController>();
  final _authController = Get.find<AuthController>();

  // Get All Friends
  void getAllFriends() async {
    friendsLoading.value = true;
    final res = await _friendRepository.getAllFriends();

    res.fold(
      (failure) {
        AppUtils.showSnackBar(title: "Error", message: failure.message);
      },
      (friends) {
        friendsList.value = friends;
      },
    );

    friendsLoading.value = false;
  }

  // Get all Friend Requests
  void getAllReceivedRequests() async {
    receivedRequestsLoading.value = true;
    final res = await _friendRepository.getAllFriendRequests();

    res.fold(
      (failure) {
        AppUtils.showSnackBar(title: "Error", message: failure.message);
      },
      (receivedRequests) {
        receivedRequestsList.value = receivedRequests;
      },
    );

    receivedRequestsLoading.value = false;
  }

  void acceptFriendRequest({required String friendId}) async {
    actionProcessing.value = true;
    final res = await _friendRepository.acceptFriendRequest(friendId: friendId);

    res.fold(
      (failure) {
        AppUtils.showSnackBar(title: "Error", message: failure.message);
      },
      (data) {
        AppUtils.showToast(message: data.message);
        if (data.status == 0) {
          receivedRequestsList.value = receivedRequestsList
              .where((request) => request.uid != friendId)
              .toList();

          Get.back();
        }
      },
    );

    actionProcessing.value = false;
  }

  void sentRequest({
    required String friendId,
  }) async {
    actionProcessing.value = true;

    final res = await _friendRepository.sentRequest(
      friendId: friendId,
    );

    res.fold(
      (failure) {
        AppUtils.showSnackBar(title: "Errro", message: failure.message);
        actionProcessing.value = false;
      },
      (data) {
        AppUtils.showToast(
          message: data.message,
        );

        if (data.status == 0) {
          _userController.users.value = _userController.users
              .where((user) => user.uid != friendId)
              .toList();

          _authController.myProfile.value =
              _authController.myProfile.value?.copyWith(
            flames: data.falmes,
          );
          Get.back();
        }
      },
    );

    actionProcessing.value = false;
  }

  void notifySocialOpen({
    required String social,
    required String userId,
    required String friendId,
  }) async {
    final res = await _friendRepository.notifySocialOpen(
      social: social,
      userId: userId,
      friendId: friendId,
    );

    res.fold((failure) {}, (data) {});

    actionProcessing.value = false;
  }
}
