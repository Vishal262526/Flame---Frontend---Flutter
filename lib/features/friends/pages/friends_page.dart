import 'package:flame/core/routes/routes_name.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/features/friends/controllers/friend_controller.dart';
import 'package:flame/features/friends/widgets/friends_list_widget.dart';
import 'package:flame/features/friends/widgets/received_requests_list_widget.dart';
import 'package:flame/features/friends/widgets/sent_request_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage>
    with AutomaticKeepAliveClientMixin {
  final friendController = Get.put(FriendController());

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    friendController.getAllFriends();
    friendController.getAllReceivedRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Friends"),
          actions: [
            IconButton(
                onPressed: () {
                  friendController.getAllFriends();
                  friendController.getAllReceivedRequests();
                },
                icon: const Icon(Icons.refresh_outlined))
          ],
          // backgroundColor: DarkColors.primary,
          bottom: const TabBar(
            indicatorColor: kWhiteColor,
            labelColor: kWhiteColor,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                text: "Friends",
              ),
              Tab(
                text: "Received",
              ),
            ],
          ),
        ),
        body: Obx(
          () => TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FriendsListWidget(
                onTap: (userId) {
                  Get.toNamed(RoutesName.userProfile, arguments: userId);
                },
                friendsList: friendController.friendsList,
                isLoading: friendController.friendsLoading.value,
              ),
              ReceivedRequestsListWidget(
                disabled: friendController.actionProcessing.value,
                onAccepted: (friendId) {
                  // friendController.acceptFriendRequest(friendId: friendId);
                },
                requestsList: friendController.receivedRequestsList,
                isLoading: friendController.receivedRequestsLoading.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
