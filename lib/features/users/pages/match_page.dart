import 'package:cached_network_image/cached_network_image.dart';
import 'package:flame/core/common/widgets/loader.dart';
import 'package:flame/core/routes/routes_name.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/features/users/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage>
    with AutomaticKeepAliveClientMixin {
  bool isDetailVisible = true;

  @override
  bool get wantKeepAlive => true;

  final _userController = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: kWhiteColor,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FontAwesomeIcons.fire,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "100",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kWhiteColor,
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
      body: Obx(
        () => _userController.isLoading.value
            ? const Loader()
            : GridView.builder(
                itemCount: _userController.users.value.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  mainAxisExtent: 350,
                ),
                itemBuilder: (context, index) {
                  final currentUser = _userController.users.value[index];

                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        RoutesName.userProfile,
                        arguments: currentUser,
                      );
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: CachedNetworkImage(
                            imageUrl: currentUser.images[0] as String,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.7, 1],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${currentUser.name}, ${currentUser.age}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
