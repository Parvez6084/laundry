
import 'package:destination/consts/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../consts/app_const.dart';
import '../../../services/auth_service.dart';
import '../../widgets/textField_widget.dart';
import 'registrationPageController.dart';

class RegistrationPage extends GetView<RegistrationPageController> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset : false,
          appBar: AppBar(title: const Text('Registration'),),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Obx((){
                    return Stack(
                      children:[
                        Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin:  const EdgeInsets.only(bottom: 30),
                            child:  const Text(AppString.appName,
                              style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFieldWidget(
                            controller: controller.emailController,
                            keyboardType: TextInputType.text,
                            label: 'Email',
                            obscureText: false,
                            onChanged: (value) {controller.registration.value.email = value.trim();},
                          ),
                          TextFieldWidget(
                            controller: controller.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            label: 'Password',
                            obscureText: true,
                            onChanged: (value) {
                              controller.registration.value.password = value.trim();
                            },
                          ),
                          TextFieldWidget(
                            controller: controller.rePasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            label: 'RePassword',
                            obscureText: true,
                            onChanged: (value) {
                              controller.registration.value.rePassword = value.trim();
                            },
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Checkbox(
                                  value: controller.checked.value,
                                  onChanged: (value) {
                                    controller.checked.value = value!;
                                  },
                                  side: const BorderSide(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'I Agree ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              const SizedBox(
                                  height: 80,
                                  width: 250,
                                  child: Text(
                                    AppString.trams,
                                    textAlign: TextAlign.justify,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            width: size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                if(controller.checked.value){
                                if(controller.registration.value.password == controller.registration.value.rePassword){
                                  controller.saveRegistrationData(context);
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text('Password and RePassword Not Match'),
                                    backgroundColor: Colors.pink,
                                  )) ;
                                }}else{
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text('Check the agree button'),
                                    backgroundColor: Colors.pink,
                                  )) ;
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  textStyle:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                              child: const Text('Registration'),
                            ),
                          ),
                        ],
                      ),
                        Obx(() => Align(alignment:Alignment.center,
                            child: controller.loading.isTrue ?
                            const CircularProgressIndicator() : Container())),
                    ]);
                  })
              ),
            ),
          ),
        )
      ),
    );
  }

}




