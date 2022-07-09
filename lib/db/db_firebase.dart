import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:destination/consts/app_const.dart';
import 'package:destination/model/profile_model.dart';

class DBFireBase{

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<int> userProfileData(String uid) async{
   final snapshot = await _db.collection(AppConst.collectionUser).where('uid',isEqualTo: uid).get();
   return snapshot.docs.length;
  }

  static  Stream<QuerySnapshot<Map<String, dynamic>>> getProfileData(String uid) =>
      _db.collection(AppConst.collectionUser).where('uid',isEqualTo: uid).snapshots();

  static Future<QuerySnapshot<Map<String, dynamic>>> fetchProfileData(String uid)async{
    final snapshot = await _db.collection(AppConst.collectionUser).where('uid',isEqualTo: uid).get();
    return snapshot;
  }

}