import 'package:flame/core/common/widgets/center_text.dart';
import 'package:flame/core/common/widgets/loader.dart';
import 'package:flame/features/friends/models/friend_request_model.dart';
import 'package:flame/features/friends/widgets/sent_request_card.dart';
import 'package:flutter/material.dart';

class SentRequestListWidget extends StatelessWidget {
  final List<FriendRequestModel> sentRequestList;
  final bool isLoading;

  const SentRequestListWidget({
    super.key,
    required this.sentRequestList,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loader()
        : sentRequestList.isEmpty
            ? const CenterText(text: "No Request Found")
            : ListView.separated(
                itemCount: sentRequestList.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  final user = sentRequestList[index];
                  return SentRequestCard(
                    user: user,
                  );
                },
              );
  }
}
