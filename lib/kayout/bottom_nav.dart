import 'package:flame/features/users/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MainLayout extends StatefulWidget {
  MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final _navigationServices = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _navigationServices
              .pages[_navigationServices.selectedIndex.value],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _navigationServices.selectedIndex.value,
          onDestinationSelected: _navigationServices.updateSelectedIndex,
          destinations: [
            NavigationDestination(
              icon: FaIcon(
                _navigationServices.selectedIndex.value == 0
                    ? Icons.home
                    : Icons.home_outlined,
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: FaIcon(
                _navigationServices.selectedIndex.value == 1
                    ? Icons.group
                    : Icons.group_outlined,
              ),
              label: "Friends",
            ),
            NavigationDestination(
              icon: FaIcon(
                _navigationServices.selectedIndex.value == 3
                    ? Icons.person
                    : Icons.person_outline,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
