import 'package:get/get.dart';

import 'profilePageController.dart';

class ProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfilePageController>(ProfilePageController());

  }
}
