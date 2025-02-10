import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/core/utils/app_utils.dart';
import 'package:flame/core/utils/date_time_utils.dart';
import 'package:flame/core/utils/social_utils.dart';
import 'package:flame/core/utils/string_utils.dart';
import 'package:flame/features/profile/controller/friend_profile_controller.dart';
import 'package:flame/features/profile/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class FriendProfilePage extends StatefulWidget {
  const FriendProfilePage({super.key});

  @override
  State<FriendProfilePage> createState() => _FriendProfilePageState();
}

class _FriendProfilePageState extends State<FriendProfilePage> {
  final _friendController = Get.put(FriendProfileController());

  final friendId = Get.arguments as String;

  @override
  void initState() {
    _friendController.loadFriendProfile(friendId: friendId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("User images is ....");

    return Obx(
      () => Scaffold(
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
        body: Skeletonizer(
          enabled: _friendController.isLoading.value,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: DarkColors.border1,
                  height: Get.height / 1.3,
                  child: PageView.builder(
                    itemCount: _friendController.profile.value?.images.length,
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: _friendController
                                .profile.value?.images[index] ??
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
                      Text(
                        "${_friendController.profile.value?.name ?? "User Name"}, ${_friendController.profile.value?.age ?? "00"}",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
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
                                "${_friendController.profile.value?.city}, ${_friendController.profile.value?.state}",
                                style: TextStyle(
                                  color: kWhiteColor.withOpacity(0.8),
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
                                    _friendController
                                            .profile.value?.gender.name ??
                                        "Gender"),
                                style: TextStyle(
                                  color: kWhiteColor.withOpacity(0.8),
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
                                _friendController.profile.value?.lastActive ??
                                    DateTime.now()),
                            style: TextStyle(
                              color: kWhiteColor.withOpacity(0.8),
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const Text(
                        "Connect On",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: [
                          if (_friendController
                                  .profile.value?.snapchatUsername !=
                              null)
                            Expanded(
                              child: SocialButton(
                                icon: Icons.snapchat,
                                onTap: () async {
                                  try {
                                    await launchUrl(
                                        SocialUtils.getSnapchatUrl(
                                          _friendController
                                              .profile.value!.snapchatUsername!,
                                        ),
                                        mode: LaunchMode.externalApplication);
                                  } catch (e) {
                                    AppUtils.showSnackBar(
                                      title: "Error",
                                      message: "Something went wrong",
                                    );
                                  }
                                },
                              ),
                            ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          if (_friendController
                                  .profile.value?.instagramUsername !=
                              null)
                            Expanded(
                              child: SocialButton(
                                icon: FontAwesomeIcons.instagram,
                                onTap: () async {
                                  try {
                                    await launchUrl(
                                        SocialUtils.getInstagramUrl(
                                          _friendController.profile.value!
                                              .instagramUsername!,
                                        ),
                                        mode: LaunchMode.externalApplication);
                                  } catch (e) {
                                    AppUtils.showSnackBar(
                                      title: "Error",
                                      message: "Something went wrong",
                                    );
                                  }
                                },
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
                        children: _friendController.profile.value?.interests
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
