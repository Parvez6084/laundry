import 'package:destination/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/helper.dart';

class LoginPageController extends GetxController {
  var userName = ''.obs;
  var password = ''.obs;
  var loading = false.obs;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void saveLoginData(BuildContext context) async {
    loading.isTrue;
    if (userName.value.isNotEmpty && password.value.isNotEmpty) {
      try {
        final user = await FireBaseAuthService.login(userName.value, password.value);
        loading.isFalse;
        if (user != null) { Get.offAllNamed(Routes.homePage);}
      } catch (e) {
        loading.isFalse;
        List message = Helper.textSplit(e.toString());
        Helper.failNotice('login', 'login message', 'Login fail', '${message[1]}');
      }
    }
  }
}
