import 'package:flame/core/utils/app_utils.dart';
import 'package:flame/features/friends/models/friend_model.dart';
import 'package:flame/features/friends/models/friend_profile_model.dart';
import 'package:flame/features/friends/models/friend_request_model.dart';
import 'package:flame/features/friends/repository/friend_repository.dart';
import 'package:get/get.dart';

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
      (successMessage) {
        AppUtils.showToast(message: successMessage);
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
      (successMessage) {
        AppUtils.showToast(
          message: successMessage['message'],
        );

        Get.back();
      },
    );

    actionProcessing.value = false;
  }
}
