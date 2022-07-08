import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../home_page/homePageController.dart';

class HistoryPage extends GetView<HomePageController> {
  final ScrollController scrollController;
  const HistoryPage( this.scrollController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black54,
      body: Container(

      ),
    );
  }
}
