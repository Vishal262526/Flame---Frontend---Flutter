import 'package:cached_network_image/cached_network_image.dart';
import 'package:flame/core/common/widgets/button.dart';
import 'package:flame/core/routes/routes_name.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/core/utils/app_utils.dart';
import 'package:flame/core/utils/social_utils.dart';
import 'package:flame/features/auth/controller/auth_controller.dart';
import 'package:flame/features/profile/widgets/profile_menu_bottom_sheet.dart';
import 'package:flame/features/profile/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  final _authController = Get.find<AuthController>();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                backgroundColor: DarkColors.border1,
                const ProfileMenuBottomSheet(),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        _authController.myProfile.value?.images[0] ?? "",
                      ),
                      fit: BoxFit.cover),
                  color: DarkColors.primary,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _authController.myProfile.value?.name ?? "User name",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kWhiteColor,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Age: ${_authController.myProfile.value?.age}",
                style: const TextStyle(
                  fontSize: 20,
                  color: DarkColors.gray,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Button(
                // fullWidth: true,

                text: "See how others view you!",
                onTap: () {
                  Get.toNamed(
                    RoutesName.myProfile,
                    arguments: _authController.myProfile.value!,
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  if (_authController.myProfile.value?.snapchatUsername != null)
                    Expanded(
                      child: Expanded(
                        child: SocialButton(
                          icon: FontAwesomeIcons.snapchat,
                          onTap: () async {
                            try {
                              await launchUrl(
                                  SocialUtils.getSnapchatUrl(_authController
                                      .myProfile.value!.snapchatUsername!),
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
                    ),
                  const SizedBox(
                    width: 16,
                  ),
                  if (_authController.myProfile.value?.instagramUsername !=
                      null)
                    Expanded(
                      child: Expanded(
                        child: SocialButton(
                          icon: FontAwesomeIcons.instagram,
                          onTap: () async {
                            try {
                              await launchUrl(
                                  SocialUtils.getInstagramUrl(
                                    _authController
                                        .myProfile.value!.instagramUsername!,
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
                    )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RoutesName.flames);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: kWhiteColor.withOpacity(0.5),
                    ),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Flames",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 4.0,
                        children: [
                          Icon(
                            FontAwesomeIcons.fire,
                            size: 30,
                          ),
                          Text(
                            "${_authController.myProfile.value!.flames ?? 0}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
