import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:destination/model/profile_model.dart';
import 'package:destination/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ProfilePageController extends GetxController {

  String? path;
  FirebaseAuth? auth;
  final imagePath = Rxn<String>();
  var profileData = ProfileModel().obs;
  var storageRef = FirebaseStorage.instance.ref();
  var isEmailVerified = FireBaseAuthService.isEmailVerified().obs;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser()async{
    return users.add({
      'full_name': profileData.value.fullName,
      'email': profileData.value.email,
      'phone_number': profileData.value.phoneNumber ,
      'address':profileData.value.address,
    }).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void pickImage()async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    path = file?.path;
    if (path != null) {
      imageCropping(path!);
    }
  }

  void imageCropping(String path)async{
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      maxWidth: 512,
      maxHeight: 512,
      cropStyle: CropStyle.circle,
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
}

  @override
  void onInit() async {
    auth = FirebaseAuth.instance;
    if(auth!=null){ profileData.value.email = auth?.currentUser?.email;}
    super.onInit();
  }

  var formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  void saveProfileData(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }

  void logOut (){
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
      onConfirm: ()async {await FireBaseAuthService.logout();}
    );
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
