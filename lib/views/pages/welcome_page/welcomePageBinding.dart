
import 'package:destination/views/pages/welcome_page/welcomePageController.dart';
import 'package:get/get.dart';

class WelcomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomePageController>(() => WelcomePageController());
  }
}


