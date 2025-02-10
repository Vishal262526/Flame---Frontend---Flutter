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

      final friends =
          data.map((doc) => FriendModel.fromJson(doc.data())).toList();

      return right(friends);
    } catch (e) {
      print(e);
      return left(
        Failure(),
      );
    }
  }

  Future<Either<Failure, String>> acceptFriendRequest({
    required FriendRequestModel friend,
  }) async {
    try {
      // Check friend request is exists or not
      final acceptMessage = await _client.rpc("accept_request") as String;

      return right(acceptMessage);
    } catch (e) {
      print(e);
      return left(
        Failure(),
      );
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> sentRequest({
    required String friendId,
  }) async {
    try {
      final acceptMessage =
          await _client.rpc("sent_request") as Map<String, dynamic>;

      return right(acceptMessage);
    } catch (e) {
      print("Error while send friend request ......");
      print(e);
      return left(Failure());
    }
  }
}
