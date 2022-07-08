import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helper{

  static List textSplit(String s){
    int idx = s.indexOf("]");
    List parts = [s.substring(0,idx).trim(), s.substring(idx+1).trim()];
    return parts;
  }

  static void failNotice(String title, String body, String message, String error) {
    Get.snackbar(title, body,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        messageText: Text(
          error,
          style: const TextStyle(color: Colors.white),
        ));
  }

}