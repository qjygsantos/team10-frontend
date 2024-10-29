import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psykitz/config/app_colors.dart';
import 'package:psykitz/src/select_bluetooth_screen/view/select_bluetooth_view.dart';
import 'package:sizer/sizer.dart';
import '../../../config/app_fontsizes.dart';
import '../../../services/bluetooth_service.dart';
import '../../../services/open_bluetooth_setting_dialog.dart';
import '../../activity_screen/view/activity_view.dart';
import '../../learning_screen/view/learning_view.dart';
import '../../remote_controll_screen/view/remote_controll_view.dart';
import '../../select_bluetooth_screen/controller/select_bluetooth_controller.dart';
import '../../take_photo_screen/view/take_photo_view.dart';
import '../controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Padding(
          padding: EdgeInsets.only(top: 7.h, left: 5.w, right: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        "What would you like",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.large, color: AppColors.lightblue),
                      ),
                      Text(
                        "to learn today? 🤖",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.large, color: AppColors.lightblue),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.to(() => const RemoteControllPage());
                          },
                          icon: const Icon(
                            Icons.gamepad,
                            color: AppColors.lightblue,
                          )),
                      IconButton(
                          onPressed: () async {
                            if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                              OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                            } else {
                              Get.find<SelectBluetoothController>().getBluetoothDevices().then((value) {
                                Get.to(() => const SelectBluetoothPage());
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.bluetooth,
                            color: AppColors.lightblue,
                          )),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                height: 18.h,
                width: 100.w,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), backgroundColor: AppColors.lightyellow),
                    onPressed: () {
                      Get.to(() => const LearningPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Start learning",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.extraLarge, color: AppColors.lightblue),
                        ),
                        SizedBox(height: 14.h, width: 20.w, child: Image.asset("assets/images/bulb.png"))
                      ],
                    )),
              ),
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                height: 18.h,
                width: 100.w,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), backgroundColor: AppColors.lightblue),
                    onPressed: () {
                      Get.to(() => const ActivityPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Activity",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.extraLarge, color: Colors.white),
                        ),
                        SizedBox(height: 14.h, width: 20.w, child: Image.asset("assets/images/gear.png"))
                      ],
                    )),
              ),
              SizedBox(
                height: 2.h,
              ),
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  SizedBox(
                    height: 25.h,
                    width: 100.w,
                  ),
                  Positioned(
                    top: 3.h,
                    child: SizedBox(
                      height: 18.h,
                      width: 90.w,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), backgroundColor: const Color.fromARGB(255, 236, 90, 77)),
                          onPressed: () async {
                            if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                              OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                            } else {
                              Get.to(() => const TakePhotoPage());
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Take Photo",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.extraLarge, color: Colors.white),
                              ),
                            ],
                          )),
                    ),
                  ),
                  Positioned(
                      right: 1.w,
                      bottom: 5.h,
                      child: GestureDetector(
                        onTap: () async {
                          if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                            OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                          } else {
                            Get.to(() => const TakePhotoPage());
                          }
                        },
                        child: SizedBox(height: 20.h, width: 40.w, child: Image.asset("assets/images/robot.png")),
                      )),
                  Positioned(
                      right: 30.w,
                      bottom: 8.h,
                      child: GestureDetector(
                        onTap: () async {
                          log("here");
                          if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                            OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                          } else {
                            Get.to(() => const TakePhotoPage());
                          }
                        },
                        child: SizedBox(height: 7.h, width: 10.w, child: Image.asset("assets/images/camera.png")),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 10.h,
        width: 100.w,
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 7.h,
              width: 100.w,
              decoration: BoxDecoration(color: AppColors.lightblue, borderRadius: BorderRadius.circular(40)),
              child: Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(() => const LearningPage());
                        },
                        icon: Icon(
                          Icons.category_rounded,
                          size: 25.sp,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {
                          Get.to(() => const ActivityPage());
                        },
                        icon: Icon(
                          Icons.home_rounded,
                          size: 25.sp,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () async {
                          if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                            OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                          } else {
                            Get.to(() => const TakePhotoPage());
                          }
                        },
                        icon: Icon(
                          Icons.camera,
                          size: 25.sp,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
