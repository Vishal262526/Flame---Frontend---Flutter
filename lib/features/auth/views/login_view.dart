import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flame/core/common/widgets/button.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: Get.width / 1.3,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Center(
                        child: Text(
                          "Welcome to Flame",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        "Make new Friends",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      SvgPicture.asset("assets/icons/logo.svg"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Button(
                  fullWidth: true,
                  icon: const FaIcon(
                    FontAwesomeIcons.google,
                  ),
                  text: "Continue",
                  onTap: () {
                    _authController.connectWithGoogle();
                  },
                  isDisabled: _authController.isLoading.value,
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
