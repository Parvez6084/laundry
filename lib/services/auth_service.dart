import 'package:firebase_auth/firebase_auth.dart';

import '../model/registration_model.dart';

class FireBaseAuthService {

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<User?> login(String email, String password) async {
       final credentials =  await _auth.signInWithEmailAndPassword(email: email, password: password);
       return credentials.user;
  }

  static Future<User?> registration(RegistrationModel registration) async {
      final regCredentials = await _auth.createUserWithEmailAndPassword(email: registration.email!, password: registration.password!);
      return regCredentials.user;
  }

  static bool isEmailVerified() => _auth.currentUser!.emailVerified;

  static Future<void> sendEmailVerification() async {
    return await _auth.currentUser!.sendEmailVerification();
  }

  static Future<void> updatePassword(String newPassword) {
    return _auth.currentUser!.updatePassword(newPassword);
  }

  static Future<void>logout()async{ return _auth.signOut();}

  

}
