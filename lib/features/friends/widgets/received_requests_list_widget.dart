import 'package:flame/core/common/widgets/center_text.dart';
import 'package:flame/core/common/widgets/loader.dart';
import 'package:flame/features/friends/models/friend_request_model.dart';
import 'package:flame/features/friends/widgets/request_card.dart';
import 'package:flutter/material.dart';

class ReceivedRequestsListWidget extends StatelessWidget {
  final Function(String friendId) onAccepted;
  final List<FriendRequestModel> requestsList;
  final bool disabled;
  final bool isLoading;

  const ReceivedRequestsListWidget({
    super.key,
    required this.onAccepted,
    required this.disabled,
    required this.requestsList,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loader()
        : requestsList.isEmpty
            ? const CenterText(text: "No Request Found")
            : ListView.separated(
                padding: const EdgeInsets.only(top: 16.0),
                itemCount: requestsList.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  final user = requestsList[index];
                  return ReceivedRequestCard(
                    disabled: disabled,
                    onAccepted: (request) {},
                    user: user,
                  );
                },
              );
  }
}
