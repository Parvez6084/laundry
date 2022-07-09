import 'dart:io';

class ProfileModel {
  File? imageFile;
  String? uid;
  String? imgUrl;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? address;
  String? oldPassword;
  String? newPassword;

  ProfileModel(
      {
      this.uid,
      this.imageFile,
      this.imgUrl,
      this.email,
      this.fullName,
      this.phoneNumber,
      this.address,
      this.oldPassword,
      this.newPassword});

  ProfileModel.fromData(Map<String, dynamic> data)
      :
        imgUrl = data['img_url'],
        email = data['email'],
        fullName = data['full_name'],
        phoneNumber = data['phone_number'],
        address = data['address'];

  Map<String, dynamic> toJson() {
    return {
      'img_url': imgUrl,
      'email': email,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'address': address,
    };
  }

  @override
  String toString() {
    return 'ProfileModel {image: ${imgUrl}, email:$email, fullName: $fullName, phoneNumber: $phoneNumber, address: $address, oldPassword: $oldPassword, newPassword: $newPassword}';
  }
}
