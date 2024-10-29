import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MessageDialog {
  static showMessageDialog({required String message}) async {
    Get.dialog(
      AlertDialog(
        content: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 20.w,
                width: 30.w,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/robot.png"))),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.sp, color: Colors.black),
                  )),
              SizedBox(
                height: 2.h,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
