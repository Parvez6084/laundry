import 'package:destination/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/helper.dart';

class LoginPageController extends GetxController {
  var userName = ''.obs;
  var password = ''.obs;
  var loading = false.obs;
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void saveLoginData(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      loading.value = true;
      try {
        final user = await FireBaseAuthService.login(userName.value, password.value);
        loading.value = false;
        if (user != null) { Get.offAllNamed(Routes.homePage);}
      } catch (e) {
        loading.value = false;
        List message = Helper.textSplit(e.toString());
        Helper.failNotice('login', 'login message', 'Login fail', '${message[1]}');
      }
    }
  }
}
