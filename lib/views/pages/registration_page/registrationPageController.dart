
import 'package:destination/model/registration_model.dart';
import 'package:destination/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/helper.dart';


class RegistrationPageController extends GetxController{

  var checked = false.obs;
  var loading = false.obs;
  var registration = RegistrationModel().obs;

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  void saveRegistrationData(BuildContext context) async {
     loading.isTrue;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try{
       final user = await FireBaseAuthService.registration(registration.value);
       loading.isFalse;
       if (user != null) { Get.offAllNamed(Routes.homePage);}
      }catch(e){
        loading.isFalse;
        List message = Helper.textSplit(e.toString());
        Helper.failNotice('registration', 'registration message', 'Account creating fail', '${message[1]}');
      }
    }
  }




  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }
}