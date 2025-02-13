import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flame/core/common/enums/gender_enum.dart';
import 'package:flame/core/common/models/user_model.dart';
import 'package:flame/core/common/widgets/button.dart';
import 'package:flame/core/routes/routes_name.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/core/utils/app_utils.dart';
import 'package:flame/core/utils/date_time_utils.dart';
import 'package:flame/core/utils/string_utils.dart';
import 'package:flame/features/friends/controllers/friend_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({
    super.key,
  });

  final friend = Get.arguments as UserModel;

  final _friendController = Get.put(FriendController());

  void _handleAddFriend() {
    _friendController.sentRequest(friendId: friend.uid);
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
        actions: [
          GestureDetector(
            onTap: () {
              AppUtils.showToast(
                message: "This Feature is under development",
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: CircleAvatar(
                backgroundColor: kWhiteColor,
                child: Icon(
                  Icons.flag,
                  color: kBlackColor,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: DarkColors.border1,
              height: Get.height / 1.3,
              child: PageView.builder(
                itemCount: friend.images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        RoutesName.viewImage,
                        arguments: friend.images[index],
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: friend.images[index] ??
                          "https://t4.ftcdn.net/jpg/05/17/53/57/360_F_517535712_q7f9QC9X6TQxWi6xYZZbMmw5cnLMr279.jpg",
                      fit: BoxFit.cover,
                    ),
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
                          "${friend.name}, ${friend.age}",
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
                              color: kWhiteColor.withValues(alpha: 0.8),
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
                            "${friend.city}, ${friend.state}",
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
                          Icon(
                            friend.gender == Gender.male
                                ? Icons.male
                                : Icons.female,
                          ),
                          Text(
                            StringUtils.convertToCapitalize(friend.gender.name),
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
                        DateTimeUtils.convertToActiveString(friend.lastActive),
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
                    children: friend.interests
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
      ),
    );
  }
}
