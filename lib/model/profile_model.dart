import 'dart:io';

class ProfileModel {
  String? id;
  String? uid;
  String? downloadImgUrl;
  String? localImgPath;
  String? cloudImgPath;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? address;
  String? oldPassword;
  String? newPassword;

  ProfileModel(
      {
      this.id,
      this.uid,
      this.downloadImgUrl,
      this.cloudImgPath,
      this.localImgPath,
      this.email,
      this.fullName,
      this.phoneNumber,
      this.address,
      this.oldPassword,
      this.newPassword});

  ProfileModel.fromData(Map<String, dynamic> data)
      : id = data['id'],
        uid = data['uid'],
        downloadImgUrl = data['img_url'],
        cloudImgPath = data['cloud_path'],
        localImgPath = data['local_path'],
        email = data['email'],
        fullName = data['full_name'],
        phoneNumber = data['phone_number'],
        address = data['address'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'img_url': downloadImgUrl,
      'cloud_path': cloudImgPath,
      'local_path': localImgPath,
      'email': email,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'address': address,
    };
  }

  @override
  String toString() {
    return 'ProfileModel{uid: $uid, downloadImgUrl: $downloadImgUrl, localImgPath: $localImgPath, cloudImgPath: $cloudImgPath, email: $email, fullName: $fullName, phoneNumber: $phoneNumber, address: $address, oldPassword: $oldPassword, newPassword: $newPassword}';
  }
}
