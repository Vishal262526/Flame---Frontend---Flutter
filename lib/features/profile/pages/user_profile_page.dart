import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flame/core/common/widgets/button.dart';
import 'package:flame/core/common/widgets/loader.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/core/utils/date_time_utils.dart';
import 'package:flame/core/utils/string_utils.dart';
import 'package:flame/features/friends/controllers/friend_controller.dart';
import 'package:flame/features/profile/controller/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({
    super.key,
  });

  final friendId = Get.arguments as String;

  final _friendController = Get.put(FriendController());
  final _userProfileController = Get.put(UserProfileController());

  void _handleAddFriend() {
    _friendController.sentRequest(friendId: friendId);
  }

  @override
  Widget build(BuildContext context) {
    print("User images is ....");

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
      body: Obx(() => _userProfileController.isLoading.value
          ? const Loader()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    color: DarkColors.border1,
                    height: Get.height / 1.3,
                    child: PageView.builder(
                      itemCount:
                          _userProfileController.user.value?.images.length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: _userProfileController
                                  .user.value?.images[index] ??
                              "https://t4.ftcdn.net/jpg/05/17/53/57/360_F_517535712_q7f9QC9X6TQxWi6xYZZbMmw5cnLMr279.jpg",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${_userProfileController.user.value ?? "Name"}, ${_userProfileController.user.value?.age ?? 0}",
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Button(
                              text: "Add Friend",
                              onTap: _handleAddFriend,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8.0,
                              children: [
                                CountryFlag.fromCountryCode(
                                  "IN",
                                  shape: const Rectangle(),
                                  width: 20,
                                  height: 20,
                                ),
                                Text(
                                  "India",
                                  style: TextStyle(
                                    color: kWhiteColor.withOpacity(0.8),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8.0,
                              children: [
                                Icon(Icons.location_on_outlined),
                                Text(
                                  "${_userProfileController.user.value?.city ?? "City"}, ${_userProfileController.user.value?.state ?? "state"}",
                                  style: TextStyle(
                                    color: kWhiteColor.withValues(alpha: 0.8),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8.0,
                              children: [
                                const Icon(
                                  Icons.man_outlined,
                                ),
                                Text(
                                  StringUtils.convertToCapitalize(
                                      _userProfileController
                                              .user.value?.gender.name ??
                                          "Gender"),
                                  style: TextStyle(
                                    color: kWhiteColor.withValues(alpha: 0.8),
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8.0,
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.greenAccent,
                            ),
                            Text(
                              DateTimeUtils.convertToActiveString(
                                  _userProfileController
                                          .user.value?.lastActive ??
                                      DateTime.now()),
                              style: TextStyle(
                                color: kWhiteColor.withValues(alpha: 0.8),
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const Text(
                          "Interests",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Wrap(
                          spacing: 16.0,
                          children: _userProfileController.user.value?.interests
                                  .map(
                                    (e) => Chip(
                                      label: Text(e),
                                    ),
                                  )
                                  .toList() ??
                              [],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                ],
              ),
            )),
    );
  }
}
