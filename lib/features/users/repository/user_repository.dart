import 'package:fpdart/fpdart.dart';
import 'package:flame/core/common/models/user_model.dart';
import 'package:flame/core/failures/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UsersRepository {
  final _client = Supabase.instance.client;

  Future<Either<Failure, List<UserModel>>> loadUserProfiles() async {
    try {
      final usersData = await _client.rpc("load_users", params: {
        "gender": 1,
      }) as List;

      final users = usersData.map((user) => UserModel.fromJson(user)).toList();

      return right(users);
    } catch (e) {
      print("Error for Fetching users ...........");
      print(e.toString());
      return left(Failure());
    }
  }
}
