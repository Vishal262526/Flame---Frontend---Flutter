import 'package:flame/core/common/widgets/center_text.dart';
import 'package:flame/core/common/widgets/loader.dart';
import 'package:flame/features/friends/models/friend_model.dart';
import 'package:flame/features/friends/widgets/friend_card.dart';
import 'package:flutter/material.dart';

class FriendsListWidget extends StatelessWidget {
  final List<FriendModel> friendsList;
  final Function(String userId) onTap;
  final bool isLoading;

  const FriendsListWidget({
    super.key,
    required this.onTap,
    required this.friendsList,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loader()
        : friendsList.isEmpty
            ? const CenterText(text: "No Friends Found")
            : ListView.builder(
                itemCount: friendsList.length,
                itemBuilder: (context, index) {
                  final friend = friendsList[index];
                  return FriendCard(
                    onTap: () {
                      onTap(friend.uid);
                    },
                    friend: friend,
                  );
                },
              );
  }
}
