import 'dart:convert';

import 'package:flame/core/common/models/response_data.dart';
import 'package:flame/core/failures/failure.dart';
import 'package:flame/features/friends/models/friend_model.dart';
import 'package:flame/features/friends/models/friend_request_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FriendRepository {
  final _uid = Supabase.instance.client.auth.currentSession?.user.id;
  final _client = Supabase.instance.client;

  Future<Either<Failure, List<FriendRequestModel>>>
      getAllFriendRequests() async {
    try {
      final data = await _client.rpc("get_friend_requests") as List;

      final requestsList =
          data.map((doc) => FriendRequestModel.fromJson(doc)).toList();

      return right(requestsList);
    } catch (e) {
      print("Error during get all friend requests .......");
      print(e);
      return left(
        Failure(),
      );
    }
  }

  // Future<Either<Failure, List<FriendRequestModel>>>
  //     getAllSentFriendRequests() async {
  //   try {
  //     final data = await _firestore
  //         .collection("friend_requests")
  //         .where("sender_id", isEqualTo: uid)
  //         .get();

  //     final requestsList = data.docs
  //         .map((doc) => FriendRequestModel.fromJson(doc.data()))
  //         .toList();

  //     return right(requestsList);
  //   } catch (e) {
  //     print(e);
  //     return left(
  //       Failure(),
  //     );
  //   }
  // }

  Future<Either<Failure, List<FriendModel>>> getAllFriends() async {
    try {
      final data = await _client.rpc("get_friends") as List;

      final friends = data.map((doc) => FriendModel.fromJson(doc)).toList();

      return right(friends);
    } catch (e) {
      print(e);
      return left(
        Failure(),
      );
    }
  }

  Future<Either<Failure, ResponseData>> acceptFriendRequest({
    required String friendId,
  }) async {
    try {
      // Check friend request is exists or not
      final res = await _client
          .rpc("accept_request", params: {"friend_id": friendId}) as String;

      final jsonData = json.decode(res) as Map<String, dynamic>;

      final data = ResponseData.fromJson(jsonData);

      return right(data);
    } catch (e) {
      print(e);
      return left(
        Failure(),
      );
    }
  }

  Future<Either<Failure, void>> notifySocialOpen({
    required String social,
    required String userId,
    required String friendId,
  }) async {
    try {
      // Check friend request is exists or not
      final res = await _client.functions.invoke("open_social_notification",
          body: {"social": social, "user_id": userId, "friend_id": friendId});

      return right(null);
    } catch (e) {
      print(e);
      return left(
        Failure(),
      );
    }
  }

  Future<Either<Failure, ResponseData>> sentRequest({
    required String friendId,
  }) async {
    try {
      final jsonStringData = await _client.rpc(
        "sent_request",
        params: {"friend_id": friendId},
      ) as String;

      final jsonData = json.decode(jsonStringData) as Map<String, dynamic>;

      final data = ResponseData.fromJson(jsonData);

      return right(data);
    } catch (e) {
      print("Error while send friend request ......");
      print(e);
      return left(Failure());
    }
  }
}
