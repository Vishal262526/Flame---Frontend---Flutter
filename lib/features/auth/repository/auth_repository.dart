import 'package:flame/core/common/models/user_model.dart';
import 'package:flame/core/failures/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final _client = Supabase.instance.client;

  Future<Either<Failure, CurrentUserModel?>> getMyProfile() async {
    try {
      final uid = Supabase.instance.client.auth.currentSession?.user.id;
      final userDoc = await _client.from("users").select("*").eq("uid", uid!);

      if (userDoc.isEmpty) {
        return right(null);
      }

      final user = CurrentUserModel.fromJson(userDoc[0]);
      return right(user);
    } catch (e) {
      print("Error is here ......");
      print(e);
      return left(Failure());
    }
  }

  Future<Either<Failure, void>> signInWithGoogle() async {
    try {
      /// TODO: update the Web client ID with your own.
      ///
      /// Web Client ID that you registered with Google Cloud.
      const webClientId = 'my-web.apps.googleusercontent.com';

      /// TODO: update the iOS client ID with your own.
      ///
      /// iOS Client ID that you registered with Google Cloud.
      const iosClientId = 'my-ios.apps.googleusercontent.com';

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      return right(null);
    } catch (e) {
      print(e.toString());
      return left(Failure());
    }
  }
}
