import 'package:flame/features/users/widgets/no_user_found.dart';
import 'package:flame/features/users/widgets/user_card_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flame/core/common/models/user_model.dart';
import 'package:flame/features/users/widgets/user_card.dart';

class UserList extends StatelessWidget {
  final bool isDetailVisible;
  final PageController pageController;
  final List<UserModel> userList;
  final VoidCallback onTap;
  final Function(UserModel user) onLikeTap;
  final Function(UserModel user) onDisLike;
  final VoidCallback onUndoTap;
  final VoidCallback onFetchMoreUsers;
  final Function(int index) onPageChanged;
  final bool newUserFound;

  const UserList({
    super.key,
    required this.onTap,
    required this.pageController,
    required this.userList,
    required this.isDetailVisible,
    required this.onLikeTap,
    required this.onDisLike,
    required this.onUndoTap,
    required this.onFetchMoreUsers,
    required this.onPageChanged,
    required this.newUserFound,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      allowImplicitScrolling: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: onPageChanged,
      itemCount: userList.length + 1,
      itemBuilder: (context, index) {
        if (index < userList.length) {
          return UserCard(
            isDetailVisible: isDetailVisible,
            ontap: onTap,
            user: userList[index],
            onUndo: onUndoTap,
            onDisLike: onDisLike,
            onLike: onLikeTap,
          );
        } else {
          return newUserFound
              ? NoUserFound(onRefreshTap: onFetchMoreUsers)
              : const UserCardPlaceholder();
        }
      },
    );
  }
}
