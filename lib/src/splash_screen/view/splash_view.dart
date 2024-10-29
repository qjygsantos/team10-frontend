import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
        body: SizedBox(
      height: 100.h,
      width: 100.w,
      child: Image.asset(
        "assets/images/splashimage.png",
        fit: BoxFit.cover,
      ),
    ));
  }
}
