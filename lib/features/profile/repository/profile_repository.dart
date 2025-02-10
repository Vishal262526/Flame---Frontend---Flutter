import 'dart:io';

import 'package:country_state_city/utils/utils.dart';
import 'package:flame/features/friends/models/friend_profile_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flame/core/common/models/user_model.dart';
import 'package:flame/core/exceptions/server_exception.dart';
import 'package:flame/core/failures/failure.dart';
import 'package:flame/features/profile/models/interest_model.dart';
import 'package:country_state_city/models/state.dart' as state;
import 'package:country_state_city/models/city.dart' as city;
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  final _client = Supabase.instance.client;

  Future<Either<Failure, void>> updateActiveStatus() async {
    try {
      final uid = Supabase.instance.client.auth.currentSession?.user.id;

      await _client
          .from("users")
          .update({"last_active": DateTime.now().millisecondsSinceEpoch}).eq(
        "uid",
        uid!,
      );
      return right(null);
    } catch (e) {
      print(e.toString());
      return left(Failure());
    }
  }

  Future<List<String>> uploadImages(List<File> images, String uid) async {
    try {
      final List<String> imagesUrl = [];

      for (var image in images) {
        final fileName = "$uid/${DateTime.now().millisecondsSinceEpoch}.jpg";

        final storageRef = _client.storage.from("profiles");

        await storageRef.upload(fileName, image);

        imagesUrl.add(storageRef.getPublicUrl(fileName));
      }

      return imagesUrl;
    } catch (e) {
      print("Error is found ........");
      print(e);
      throw ServerException(message: 'Something went wrong 1');
    }
  }

  Future<Either<Failure, CurrentUserModel>> updateProfile({
    required CurrentUserModel user,
    required List<File> images,
  }) async {
    try {
      final uid = _client.auth.currentSession?.user.id;

      if (uid == null) {
        return left(Failure(message: "User is not logged in"));
      }

      final imagesUrl = await uploadImages(images, uid);

      final finalUserData = user.copyWith(images: imagesUrl, uid: uid);

      await _client.from('users').insert(finalUserData.toJson());

      return right(finalUserData);
    } catch (e) {
      print("Error is found ........");
      print(e);
      return left(Failure());
    }
  }

  Future<List<InterestModel>> getAllInterests() async {
    final interestList = await _client.from("interests").select();

    return interestList
        .map(
          (doc) => InterestModel.fromJson(doc),
        )
        .toList();
  }

  Future<Either<Failure, UserModel>> getUserProfile({
    required String userId,
  }) async {
    try {
      final data = await _client
          .rpc("get_user_profile", params: {"user_id": userId}) as List;

      if (data.isEmpty) {
        return left(Failure(message: "No User Data Found"));
      }

      final userProfile = UserModel.fromJson(data[0]);
      return right(userProfile);
    } catch (e) {
      print(e);
      return Left(Failure(message: "Something went wrong"));
    }
  }

  Future<Either<Failure, FriendProfileModel>> getFriendProfile({
    required String friendId,
  }) async {
    try {
      final data = await _client.rpc(
        "get_friend_profile",
        params: {
          "friend_id": friendId,
        },
      ) as List;

      final profile =
          data.map((doc) => FriendProfileModel.fromJson(doc)).toList();

      return right(profile[0]);
    } catch (e) {
      print("Error during get all friend requests .......");
      print(e);
      return left(
        Failure(),
      );
    }
  }
}
