import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../config/app_colors.dart';
import '../../../services/bluetooth_service.dart';
import '../../../services/message_dialog.dart';
import '../../../services/open_bluetooth_setting_dialog.dart';
import '../../select_bluetooth_screen/controller/select_bluetooth_controller.dart';
import '../../select_bluetooth_screen/view/select_bluetooth_view.dart';
import '../controller/remote_controll_controller.dart';

class RemoteControllPage extends GetView<RemoteControllController> {
  const RemoteControllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          leadingWidth: 0,
          title: Text(
            "Remote Controller",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: IconButton(
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
            ),
          ],
        ),
        body: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                      OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                    } else {
                      if (Get.find<SelectBluetoothController>().connection != null) {
                        Get.find<SelectBluetoothController>().sendMessage(message: "<F>");
                      } else {
                        MessageDialog.showMessageDialog(message: "Please select bluetooth device first.");
                      }
                    }
                  },
                  child: CircleAvatar(
                    radius: 12.w,
                    backgroundColor: AppColors.lightblue,
                    child: Icon(
                      Icons.arrow_circle_up,
                      color: Colors.white,
                      size: 50.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 13.w, right: 13.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                            OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                          } else {
                            if (Get.find<SelectBluetoothController>().connection != null) {
                              Get.find<SelectBluetoothController>().sendMessage(message: "<L>");
                            } else {
                              MessageDialog.showMessageDialog(message: "Please select bluetooth device first.");
                            }
                          }
                        },
                        child: CircleAvatar(
                          radius: 12.w,
                          backgroundColor: AppColors.lightblue,
                          child: Icon(
                            Icons.arrow_circle_left_outlined,
                            color: Colors.white,
                            size: 50.sp,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                            OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                          } else {
                            if (Get.find<SelectBluetoothController>().connection != null) {
                              Get.find<SelectBluetoothController>().sendMessage(message: "<R>");
                            } else {
                              MessageDialog.showMessageDialog(message: "Please select bluetooth device first.");
                            }
                          }
                        },
                        child: CircleAvatar(
                          radius: 12.w,
                          backgroundColor: AppColors.lightblue,
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Colors.white,
                            size: 50.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                      OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                    } else {
                      if (Get.find<SelectBluetoothController>().connection != null) {
                        Get.find<SelectBluetoothController>().sendMessage(message: "<B>");
                      } else {
                        MessageDialog.showMessageDialog(message: "Please select bluetooth device first.");
                      }
                    }
                  },
                  child: CircleAvatar(
                    radius: 12.w,
                    backgroundColor: AppColors.lightblue,
                    child: Icon(
                      Icons.arrow_circle_down,
                      color: Colors.white,
                      size: 50.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
