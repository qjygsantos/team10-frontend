import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psykitz/config/app_colors.dart';
import 'package:sizer/sizer.dart';
import '../../../services/bluetooth_service.dart';
import '../../../services/open_bluetooth_setting_dialog.dart';
// import '../controller/success_and_failed_controller.dart';

class ChooseOptionDialog {
  static showOptions({
    required String arduinoCommands,
  }) {
    // var controller = Get.find<SuccessAndFailedController>();
    Get.dialog(AlertDialog(
      title: const Text("Choose send option"),
      content: SizedBox(
        width: 100.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.lightblue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                onPressed: () async {
                  if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                    OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                  } else {
                    Get.back();
                    // controller.connectToDeviceAndSendArduinoCommands(option: "1", address: Get.find<BluetoothAppService>().blueToothAddress, message: arduinoCommands);
                  }
                },
                child: const Text(
                  "Option 1",
                  style: TextStyle(color: Colors.white),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.lightblue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                onPressed: () async {
                  if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                    OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                  } else {
                    // Get.back();
                    // controller.connectToDeviceAndSendArduinoCommands(
                    //     option: "2",
                    //     address:
                    //         Get.find<BluetoothAppService>().blueToothAddress,
                    //     message: arduinoCommands);
                  }
                },
                child: const Text(
                  "Option 2",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    ));
  }
}
