import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flame/core/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flame/core/common/models/user_model.dart';
import 'package:flame/core/theme/app_colors.dart';

class UserCard extends StatelessWidget {
  final bool isDetailVisible;
  final VoidCallback ontap;
  final VoidCallback onUndo;
  final Function(UserModel user) onDisLike;
  final Function(UserModel user) onLike;

  final UserModel user;

  const UserCard({
    super.key,
    required this.isDetailVisible,
    required this.ontap,
    required this.user,
    required this.onUndo,
    required this.onDisLike,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: ontap,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: user.images.length,
            itemBuilder: (context, innerIndex) {
              return CachedNetworkImage(
                imageUrl: user.images[innerIndex],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        AnimatedOpacity(
          opacity: isDetailVisible ? 1.0 : 0,
          duration: const Duration(milliseconds: 300),
          child: IgnorePointer(
            child: Container(
              height: 56,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.7, 1.0],
                ),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: isDetailVisible ? 1.0 : 0,
          duration: const Duration(milliseconds: 300),
          child: IgnorePointer(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    kBlackColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.65, 1.0],
                ),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: isDetailVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: !isDetailVisible
              ? Container()
              : Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top, right: 8.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.sort_outlined),
                  ),
                ),
        ),
        AnimatedOpacity(
          opacity: isDetailVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: !isDetailVisible
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${StringUtils.getFirstName(user.name)}, ${user.age}",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Wrap(
                        spacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          CountryFlag.fromCountryCode(
                            "IN",
                            width: 25,
                            height: 25,
                          ),
                          const Text(
                            "India",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: onUndo,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: const Icon(
                                  Icons.undo_outlined,
                                  size: 35,
                                  color: DarkColors.secondary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                onDisLike(user);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: DarkColors.secondary,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: const Icon(
                                  Icons.close_outlined,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                onLike(user);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: DarkColors.primary,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: const Icon(
                                  Icons.favorite,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
