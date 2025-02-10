import 'package:get/get.dart';

class FilterController extends GetxController {
  final minAge = Rx<int?>(null);
  final maxAge = Rx<int?>(null);

  @override
  void onReady() {
    super.onInit();
  }
}
