import 'package:flame/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: DarkColors.primary,
        title: const Text("Notifications"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text(
          "Notifications",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: kWhiteColor,
          ),
        ),
      ),
    );
    ;
  }
}
