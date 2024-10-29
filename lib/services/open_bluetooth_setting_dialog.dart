import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OpenBluetoothSettingsDialog {
  static showBluetoothSettingsDialog() async {
    Get.dialog(
      AlertDialog(
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                FlutterBluetoothSerial.instance.openSettings();
              },
              child: const Text("Open Bluetooth Seting"))
        ],
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
              Text(
                "Enable the bluetooth of your device to continue service.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
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
