import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlamesPage extends StatelessWidget {
  const FlamesPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              FaIcon(
                FontAwesomeIcons.fire,
                size: 110,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "100",
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
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: DarkColors.border2,
                    )),
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
