import 'package:flame/core/common/widgets/input.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChatInboxPage extends StatelessWidget {
  ChatInboxPage({
    super.key,
  });

  final name = Get.parameters['name'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: DarkColors.backgroundLight,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(name ?? "name")
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: FaIcon(Icons.more_vert_outlined))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: index % 2 == 0
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    constraints: BoxConstraints(maxWidth: Get.width / 1.2),
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? DarkColors.backgroundLight
                          : DarkColors.primary,
                    ),
                    child: Text(
                      "Hello, there my name is vishal and i am from meerut and just tell me where are you from",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
          Container(
            child: const Row(
              children: [
                Expanded(
                  child: Input(
                    placeholder: "Type a Message",
                    suffixIcon: Icon(Icons.send_outlined),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
