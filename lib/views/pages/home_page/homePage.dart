import 'package:destination/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../consts/app_images.dart';
import 'homePageController.dart';

class HomePage extends GetView<HomePageController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Hi, Parvez',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                        SizedBox(height: 4,),
                        Text('We Find Smart Solution For Cloths',style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w300,fontSize: 12),),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      child: Container(
                        height: 48,
                        width: 48,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.4),
                            shape: BoxShape.circle),
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(48), // Image radius
                            child: Image.asset(AppImages.noImg, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      onTap: (){ Get.toNamed(Routes.profilePage);},
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
