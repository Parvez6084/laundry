import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  late Rx<User?> _user;
  static AuthController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _logout);
  }

  _logout(User? user) {
    if (user == null) {
      Get.offAllNamed(Routes.loginPage);
    }
  }
}
