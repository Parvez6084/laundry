
import 'package:destination/consts/app_const.dart';
import 'package:destination/views/pages/welcome_page/welcomePageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WelcomePage extends GetView<WelcomePageController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: 40,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    AppConst.appName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Your Clothes Friend',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 4,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Obx(() => Positioned(
                bottom: 100,
                left: 0,right: 0,
                child:  Align(alignment:Alignment.center,
                    child: controller.loading.isTrue ? const CircularProgressIndicator():Container())),),
            const Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Align(alignment:Alignment.center, child: Text('Let Ready To New Experience', style: TextStyle(color: Colors.blue)))),
          ],
        ),
      ),
    );
  }
}
