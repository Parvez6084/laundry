import 'dart:io';

import 'package:destination/consts/app_images.dart';
import 'package:destination/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/textField_widget.dart';
import 'profilePageController.dart';

class ProfilePage extends GetView<ProfilePageController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text('Profile'), actions: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.history))
            ]),
            body: Obx(() {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 140,
                      width: 140,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.4),
                                shape: BoxShape.circle),
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(48), // Image radius
                                child: controller.imagePath.value != null
                                    ? Image.file(
                                        File(controller.imagePath.value!),
                                        fit: BoxFit.fill)
                                    : Image.asset(AppImages.noImg,
                                        fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: -25,
                              child: RawMaterialButton(
                                onPressed: () {controller.pickImage();},
                                elevation: 2.0,
                                fillColor: Colors.white,
                                padding: const EdgeInsets.all(8),
                                shape: const CircleBorder(),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.blue,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Form(
                      key: controller.formKey,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        margin: const EdgeInsets.only(
                            top: 40, bottom: 20, left: 16, right: 16),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Row(
                               children: [
                                 const Icon(Icons.alternate_email_outlined,size: 20,color: Colors.blue),
                                 Text(' ${controller.profileModel.value.email}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black54)),
                                 const Spacer(),
                                 TextButton(
                                     onPressed: ()async{ controller.isEmailVerified.isFalse ? await FireBaseAuthService.sendEmailVerification(): null ;},
                                     style: TextButton.styleFrom( backgroundColor: controller.isEmailVerified.isFalse ?  Colors.pink.withOpacity(0.05) : null ),
                                     child: controller.isEmailVerified.isFalse ?
                                     const Text('Not Verified', style: TextStyle( fontWeight: FontWeight.normal, color: Colors.pink),) :
                                     const Text('Verified', style: TextStyle( fontWeight: FontWeight.normal, color: Colors.green),))
                               ],
                             ),
                            const Divider(thickness: 2),
                            const SizedBox(height: 8),
                            TextFieldWidget(
                              controller: controller.fullNameController,
                              keyboardType: TextInputType.text,
                              label: 'Full Name',
                              editable: controller.editable.value,
                              obscureText: false,
                              onChanged: (value) =>
                                  controller.profileModel.value.fullName = value,
                            ),
                            TextFieldWidget(
                              controller: controller.phoneNumberController,
                              keyboardType: TextInputType.text,
                              label: 'Phone Number',
                              obscureText: false,
                              editable: controller.editable.value,
                              onChanged: (value) => controller
                                  .profileModel.value.phoneNumber = value,
                            ),
                            const Text('Address',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            const SizedBox(height: 4),
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              controller: controller.addressController,
                              keyboardType: TextInputType.multiline,
                              enabled: controller.editable.value,
                              onChanged: (value) =>
                                  controller.profileModel.value.address = value,
                              validator: (value) => value!.isEmpty
                                  ? 'This field is required'
                                  : null,
                              maxLines: 5,
                              decoration: InputDecoration(
                                  fillColor: controller.editable.value == true? Colors.black26 : Colors.blueGrey,
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(8),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)))),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              width: size.width,
                              child: controller.editable.value ?
                                ElevatedButton(
                                onPressed: () {
                                  controller.saveProfileData(context);
                                  },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                    child: const Text('Submit'),
                              ): ElevatedButton(
                                onPressed: () {controller.editable.value = true;},
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.orangeAccent,
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                child: const Text('Edit'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      margin: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 16, right: 16),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Change Your Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54)),
                          const Divider(thickness: 2),
                          const SizedBox(height: 8),
                          TextFieldWidget(
                            controller: controller.oldPasswordController,
                            keyboardType: TextInputType.text,
                            label: 'Old Password',
                            obscureText: true,
                            onChanged: (value) => controller
                                .profileModel.value.oldPassword = value,
                          ),
                          TextFieldWidget(
                            controller: controller.newPasswordController,
                            keyboardType: TextInputType.text,
                            label: 'New Password',
                            obscureText: false,
                            onChanged: (value) => controller
                                .profileModel.value.newPassword = value,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            width: size.width,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orangeAccent,
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              child: const Text('Apply'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(16),
                      width: size.width,
                      child: ElevatedButton(
                        onPressed: () => controller.logOut(),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.pink,
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold)),
                        child: const Text('LogOut'),
                      ),
                    ),
                  ],
                ),
              );
            })));
  }
}
