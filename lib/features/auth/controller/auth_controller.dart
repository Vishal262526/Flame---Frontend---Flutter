import 'package:flame/core/common/models/user_model.dart';
import 'package:flame/core/routes/routes_name.dart';
import 'package:flame/core/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:flame/features/auth/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  // States
  final isLoading = false.obs;

  // Repositories
  final _authRepostiory = AuthRepository();
  final user = Rx<User?>(null);

  final myProfile = Rx<CurrentUserModel?>(null);

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    print("Event listener is running");

    Supabase.instance.client.auth.onAuthStateChange.listen(
      (authState) async {
        if (authState.session == null) {
          print("User is not logged  in .....");
          Get.offAllNamed(RoutesName.login);
        } else {
          print("User is logged  in .....");
          user.value = authState.session?.user;

          final res = await _authRepostiory.getMyProfile();

          res.fold(
            (failure) {
              AppUtils.showSnackBar(title: "Error", message: failure.message);
            },
            (profileData) {
              if (profileData == null) {
                Get.offAllNamed(RoutesName.updateProfile);
              } else {
                myProfile.value = profileData;
                Get.offAllNamed(RoutesName.mainLayout);
              }
            },
          );
        }
      },
    );
  }

  void connectWithGoogle() async {
    final res = await _authRepostiory.signInWithGoogle();

    res.fold(
      (failure) {
        AppUtils.showSnackBar(title: "Error", message: failure.message);
      },
      (userCred) {},
    );
  }
}
