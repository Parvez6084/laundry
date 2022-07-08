import 'package:destination/services/auth_service.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class WelcomePageController extends GetxController {

  var loading = true.obs;
  @override
  void onReady() {
    _initialScreen();
    super.onReady();
  }

  _initialScreen(){
    Future.delayed(const Duration(seconds: 3),(){
      loading.value = false;
      if(FireBaseAuthService.currentUser == null) {
        Get.offAllNamed(Routes.loginPage);
      } else {
        Get.offAllNamed(Routes.homePage);
      }
    });
  }

}
