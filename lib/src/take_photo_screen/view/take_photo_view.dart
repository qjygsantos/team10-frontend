import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psykitz/src/take_photo_screen/controller/take_photo_controller.dart';
import 'package:sizer/sizer.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_fontsizes.dart';
import '../../../services/bluetooth_service.dart';
import '../../../services/open_bluetooth_setting_dialog.dart';

class TakePhotoPage extends GetView<TakePhotoController> {
  const TakePhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TakePhotoController());

    return Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Padding(
            padding: EdgeInsets.only(
              top: 2.h,
            ),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SizedBox(
                      height: 30.h,
                      width: 100.w,
                      child: Image.asset(
                        "assets/images/bluecurve.png",
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                      width: 100.w,
                      child: Image.asset(
                        "assets/images/robot.png",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Take a Photo",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSizes.superextraLarge,
                      color: AppColors.lightblue),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                  child: Text(
                    "Photograph your flowchart from a top-down perspective to ensure proper identification of the flowchart pieces.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppFontSizes.medium,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                  child: Text(
                    "Supports JPG",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: AppFontSizes.regular,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () async {
                            if (!await Get.find<BluetoothAppService>()
                                .checkBlueToothEnabled()) {
                              OpenBluetoothSettingsDialog
                                  .showBluetoothSettingsDialog();
                            } else {
                              controller.takePhotoFromCamera();
                            }
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            color: AppColors.lightblue,
                            size: 60.sp,
                          )),
                      IconButton(
                          onPressed: () async {
                            if (!await Get.find<BluetoothAppService>()
                                .checkBlueToothEnabled()) {
                              OpenBluetoothSettingsDialog
                                  .showBluetoothSettingsDialog();
                            } else {
                              controller.takePhotoFromGallery();
                            }
                          },
                          icon: Icon(
                            Icons.photo,
                            color: AppColors.lightblue,
                            size: 60.sp,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
