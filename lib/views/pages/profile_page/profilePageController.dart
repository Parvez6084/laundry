import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:destination/consts/app_const.dart';
import 'package:destination/db/db_firebase.dart';
import 'package:destination/model/profile_model.dart';
import 'package:destination/services/auth_service.dart';
import 'package:destination/utils/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../routes/app_routes.dart';

class ProfilePageController extends GetxController {
  String? path;
  var editable = true.obs;
  var uploading = false.obs;
  var cloudData = false.obs;
  final imagePath = Rxn<String>();
  var profileModel = ProfileModel().obs;
  var formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  var storageRef = FirebaseStorage.instance.ref();
  var isEmailVerified = FireBaseAuthService.isEmailVerified().obs;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
 final _user = FireBaseAuthService.currentUser;



  @override
  void onInit() async {
    profileModel.value.uid = _user?.uid;
    profileModel.value.email = _user?.email;
    getProfileData();
    super.onInit();
  }

  void saveProfileData(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      editable.value = false;
      print(profileModel.value.toString());
      if(imagePath.value != null){
      //  await imgUpload(imagePath.value);
      }
        profileCloudUpload(profileModel.value).then((_) {
            Helper.successNotice('Success', 'Profile data save success');})
            .catchError((e) {
          Helper.failNotice('fail', 'data Upload', 'Failed', 'Fail to save');
        });
    }
  }

  void pickImage() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 60);
    path = file?.path;
    if (path != null) {
      imageCropping(path!);
    }
  }

  void imageCropping(String path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      maxWidth: 512,
      maxHeight: 512,
      cropStyle: CropStyle.circle,
      compressQuality: 50,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        IOSUiSettings(title: 'Cropper'),
      ],
    );

    imagePath.value = croppedFile?.path;
    profileModel.value.localImgPath = imagePath.value;
  }

  Future<void>imgUpload(String? path)async {
    final photoDir = '${AppConst.collectionProfileImg}/${DateTime.now().toIso8601String()}';
    final photoRef =  FirebaseStorage.instance.ref().child(photoDir);
    final uploadTask =  photoRef.putFile(File(path!));
    final snapshot = await uploadTask.whenComplete(() => Helper.successNotice('Success', 'Image Upload Completed'));
    final downloadUrl = await snapshot.ref.getDownloadURL();
    uploading.value = true;
    profileModel.value.cloudImgPath = photoDir;
    profileModel.value.downloadImgUrl = downloadUrl;
  }

  Future<void>profileCloudUpload(ProfileModel profileModel){

    if(cloudData.isFalse){
      cloudData.value = true;
      return DBFireBase.addUserProfile(profileModel);
    }else{
      cloudData.value = true;
      return DBFireBase.updateUserProfile(profileModel);
    }
  }


  void getProfileData() async {
    if (_user != null) {
      String? uid = _user?.uid;
     final status = await DBFireBase.userProfileData(uid!);
     if(status > 0) {
       DBFireBase.getProfileData(uid).listen((event) {
        profileModel.value = ProfileModel.fromData(event.docs[0].data());
        if (profileModel.value.fullName == null) {
          editable.value = false;
          cloudData.value = false;
        } else {
          cloudData.value = true;
          editable.value = false;
          fullNameController.text = profileModel.value.fullName!;
          addressController.text = profileModel.value.address!;
          phoneNumberController.text = profileModel.value.phoneNumber!;
        }
      });
     }
    }
  }

  void logOut() {
    Get.defaultDialog(
        title: "Warning",
        middleText: "Are you sure to LogOut ??",
        titleStyle: const TextStyle(color: Colors.orangeAccent),
        middleTextStyle: const TextStyle(color: Colors.black54),
        textConfirm: "Log Out",
        textCancel: "Cancel",
        confirmTextColor: Colors.white,
        barrierDismissible: false,
        radius: 16,
        onConfirm: () async {
          await FireBaseAuthService.logout();
          Get.offAllNamed(Routes.loginPage);
        });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();

    super.dispose();
  }

}
