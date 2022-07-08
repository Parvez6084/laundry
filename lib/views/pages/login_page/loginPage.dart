import 'package:destination/consts/app_const.dart';
import 'package:destination/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../widgets/textField_widget.dart';
import 'loginPageController.dart';

class LoginPage extends GetView<LoginPageController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 30,
              child: Padding(
                  padding: const EdgeInsets.all(32),
                  child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          AppConst.appName,
                          style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFieldWidget(
                          controller: controller.userNameController,
                          keyboardType: TextInputType.text,
                          label: 'Email',
                          obscureText: false,
                          onChanged: (value) {
                            controller.userName.value = value;
                          },
                        ),
                        TextFieldWidget(
                          controller: controller.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          label: 'Password',
                          obscureText: true,
                          onChanged: (value) {
                            controller.password.value = value;
                          },
                        ),
                        const SizedBox(height: 40,),
                        SizedBox(
                          width: size.width,
                          child: ElevatedButton(
                            onPressed: () {controller.saveLoginData(context);},
                            style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
              ),
            ),
            Obx(() => Align(alignment:Alignment.center,
                child: controller.loading.isTrue ?
                const CircularProgressIndicator() : Container())),
            Positioned(
              bottom: 40,
              left: 40,
              right: 40,
              child: TextButton(
                child: const Text('Let ready to Registration >>',
                    style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  Get.toNamed(Routes.registrationPage);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
