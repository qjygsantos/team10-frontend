import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psykitz/services/message_dialog.dart';
import 'package:psykitz/src/select_bluetooth_screen/controller/select_bluetooth_controller.dart';
import 'package:sizer/sizer.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_fontsizes.dart';
import '../../../services/bluetooth_service.dart';
import '../../../services/open_bluetooth_setting_dialog.dart';
import '../../select_bluetooth_screen/view/select_another_bluetooth_view.dart';
import '../controller/success_and_failed_controller.dart';
import '../dialog/show_code_dialog.dart';

class SuccessAndFailedPage extends GetView<SuccessAndFailedController> {
  const SuccessAndFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SuccessAndFailedController());

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Get.back();
                Get.back();
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          actions: [
            IconButton(
                onPressed: () async {
                  if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                    OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                  } else {
                    Get.find<SelectBluetoothController>().getBluetoothDevices().then((value) {
                      Get.to(() => const SelectAnotherBluetoothPage());
                    });
                  }
                },
                icon: const Icon(
                  Icons.bluetooth,
                  color: Colors.blue,
                )),
            IconButton(
                onPressed: () {
                  CodeDialog.showCodeDialog();
                },
                icon: const Icon(
                  Icons.code,
                  color: AppColors.lightblue,
                )),
            SizedBox(
              width: 3.w,
            )
          ],
        ),
        body: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Padding(
            padding: EdgeInsets.only(
              top: 2.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => controller.hasResult.value == false
                      ? Stack(
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
                        )
                      : SizedBox(
                          height: 55.h,
                          width: 100.w,
                          child: Obx(
                            () => controller.image.value == ""
                                ? const SizedBox()
                                : Image.network(
                                    controller.image.value,
                                  ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Obx(
                    () => Text(
                      controller.status.value == "Success" ? "Your robot is ready to go!" : "Something's not right, try again",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.superextraLarge, color: AppColors.lightblue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 10.h,
          width: 100.w,
          child: Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: Center(
              child: SizedBox(
                height: 7.h,
                width: 100.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.lightyellow, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  onPressed: () async {
                    if (controller.status.value == "Success") {
                      if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                        OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                      } else {
                        // ChooseOptionDialog.showOptions(arduinoCommands: controller.arduinoCommands.value);
                        // controller.connectToDeviceAndSendArduinoCommands(
                        //     option: "2", address: Get.find<BluetoothAppService>().blueToothAddress, message: controller.arduinoCommands.value);
                        if (Get.find<SelectBluetoothController>().connection != null) {
                          Get.find<SelectBluetoothController>().sendMessage(message: controller.arduinoCommands.value);
                        } else {
                          MessageDialog.showMessageDialog(message: "Please select bluetooth device first.");
                        }
                      }
                    } else {
                      Get.back();
                    }
                  },
                  child: Obx(
                    () => Text(
                      controller.status.value == "Success" ? "Submit to Robot" : "Back",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.medium, color: AppColors.lightblue),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
