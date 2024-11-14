import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:psykitz/config/app_fontsizes.dart';
import 'package:sizer/sizer.dart';
import '../../../config/app_colors.dart';
import '../../../services/bluetooth_service.dart';
import '../../../services/open_bluetooth_setting_dialog.dart';
import '../controller/take_photo_view_image_capture_controller.dart';

class TakePhotoViewImageCapturePage extends GetView<TakePhotoViewImageCaptureController> {
  const TakePhotoViewImageCapturePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TakePhotoViewImageCaptureController());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Review Photo",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: Colors.black),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: GestureDetector(
                  onTap: () {
                    controller.takePhotoFromCamera();
                  },
                  child: const Icon(
                    Icons.photo_camera_outlined,
                    color: AppColors.lightblue,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: GestureDetector(
                  onTap: () {
                    controller.takePhotoFromGallery();
                  },
                  child: const Icon(
                    Icons.image_outlined,
                    color: AppColors.lightblue,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: GestureDetector(
                  onTap: () {
                    controller.cropImage(context: context);
                  },
                  child: const Icon(
                    Icons.crop,
                    color: AppColors.lightblue,
                  )),
            ),
          ],
        ),
        body: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Obx(
            () => controller.isLoading.value
                ? Center(
                    child: SpinKitThreeBounce(
                      size: 50.sp,
                      color: AppColors.lightblue,
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Obx(() => controller.imagePath.value == ""
                            ? Container(
                                height: 75.h,
                                width: 100.w,
                                color: Colors.black,
                              )
                            : Container(
                                height: 75.h,
                                width: 100.w,
                                decoration: BoxDecoration(image: DecorationImage(image: FileImage(File(controller.imagePath.value)))),
                              )),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: SizedBox(
                          height: 7.h,
                          width: 100.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.lightyellow, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                            onPressed: () async {
                              if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                                OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                              } else {
                                controller.uploadFile();
                              }
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.medium, color: AppColors.lightblue),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
          ),
        ));
  }
}
