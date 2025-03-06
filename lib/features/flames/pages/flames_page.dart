import 'dart:async';

import 'package:flame/core/common/widgets/button.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/core/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlamesPage extends StatefulWidget {
  const FlamesPage({super.key});

  @override
  State<FlamesPage> createState() => _FlamesPageState();
}

class _FlamesPageState extends State<FlamesPage> {
  Timer? timer;
  Duration remaningTime = Duration(seconds: 0);

  void handleRemaningTime() {
    final lastCalimed = DateTime(2025, 3, 5, 16, 13);

    remaningTime = DateTimeUtils.getRemaningTime(lastCalimed);

    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (remaningTime.isNegative) {
          timer.cancel();
          remaningTime = Duration.zero;
          print("Date time is negative ");
        } else {
          print(
              "${remaningTime.inHours} : ${remaningTime.inMinutes % 60} : ${remaningTime.inSeconds % 60}");

          remaningTime = remaningTime - Duration(seconds: 1);
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleRemaningTime();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final flames = Get.arguments as int;

    final rules = [
      "Flames is a form of points within the Flame app. You will need these points in certain parts of your interaction within the app",
      "You will receive 100 Flames as a sign-up bonus",
      "For every user you refer who uses your referral code after creating an account, both you and the referred user will receive 50 Flames",
      "Sending a friend request costs 10 Flames",
      "For daily login, you will earn 50 Flames per day",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Flames"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Image.asset(
                "assets/icons/flame_light.png",
                width: 133,
              ),
              Text(
                flames.toString(),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Flames",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Button(
                text: "Claim daily flames",
                onTap: () {},
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "renewed remaning time ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: DarkColors.gray,
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: DarkColors.border2, width: 3)),
                child: Column(
                  children: [
                    Text(
                      "How Flames work?",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: rules.length,
                      itemBuilder: (context, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: CircleAvatar(
                                backgroundColor: DarkColors.gray,
                                radius: 5,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                rules[index],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: DarkColors.gray,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 8.0,
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
