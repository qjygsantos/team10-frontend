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

class TakePhotoViewImageCapturePage
    extends GetView<TakePhotoViewImageCaptureController> {
  const TakePhotoViewImageCapturePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TakePhotoViewImageCaptureController());
    return Scaffold(
        appBar: AppBar(),
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
                      Text(
                        "Review Photo",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppFontSizes.superextraLarge,
                            color: AppColors.lightblue),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Obx(() => controller.imagePath.value == ""
                            ? Container(
                                height: 60.h,
                                width: 100.w,
                                color: Colors.black,
                              )
                            : Container(
                                height: 60.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(
                                            File(controller.imagePath.value)))),
                              )),
                      ),
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: SizedBox(
                          height: 7.h,
                          width: 100.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.lightyellow,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            onPressed: () async {
                              if (!await Get.find<BluetoothAppService>()
                                  .checkBlueToothEnabled()) {
                                OpenBluetoothSettingsDialog
                                    .showBluetoothSettingsDialog();
                              } else {
                                controller.uploadFile();
                              }
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppFontSizes.medium,
                                  color: AppColors.lightblue),
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
