import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';
import '../config/app_fontsizes.dart';

class LoadingDialog {
  static showLoadingDialog() async {
    Get.dialog(
        AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
                height: 8.h,
                width: 60.w,
                child: Column(
                  children: [
                    Center(
                      child: SpinKitThreeBounce(
                          size: 25.sp, color: AppColors.lightblue),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(
                          "Loading...",
                          style: TextStyle(
                              fontSize: AppFontSizes.regular,
                              color: AppColors.dark),
                        ))
                  ],
                )),
          ),
        ),
        barrierDismissible: false);
  }
}
