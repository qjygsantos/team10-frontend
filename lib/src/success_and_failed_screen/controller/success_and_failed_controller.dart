import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';

class SuccessAndFailedController extends GetxController {
  RxString status = ''.obs;
  String result = '';
  Map resultData = {};
  RxBool hasResult = false.obs;
  RxString image = ''.obs;
  RxBool isLoading = true.obs;
  RxString pseudoCodeText = ''.obs;
  RxString arduinoCommands = ''.obs;
  static const platform = MethodChannel('com.example.psykitz/file_transfer');

  downloadCodePseudocodeFile() async {
    await FileDownloader.downloadFile(
        url: Get.find<SuccessAndFailedController>().resultData['pseudocode_url'],
        onProgress: (String? fileName, double progress) {
          log('FILE fileName HAS PROGRESS $progress');
        },
        onDownloadCompleted: (String path) async {
          log('FILE DOWNLOADED TO PATH: $path');
          String content = await File(path).readAsString();
          pseudoCodeText.value = content;
          isLoading.value = false;
        },
        onDownloadError: (String error) {
          log('DOWNLOAD ERROR: $error');
          isLoading.value = false;
          Get.snackbar("Message", "No file found!", backgroundColor: Colors.red, colorText: Colors.white);
        });
  }

  // connectToDeviceAndSendArduinoCommands({required String address, required String message, required String option}) async {
  //   try {
  //     final String result = await platform.invokeMethod('sendBluetoothMessage', {'deviceAddress': address, 'message': message, 'option': option});
  //     log("RESULT: $result");
  //     log(result);
  //     if (result == "SUCCESS") {
  //       // macAddressConnected.value = address;
  //       Get.find<BluetoothAppService>().blueToothAddress = address;
  //     } else {}
  //   } catch (exception) {
  //     log('Cannot connect, exception occured $exception');
  //   }
  // }

  @override
  void onInit() async {
    status.value = Get.arguments['status'];
    result = await Get.arguments['result'];
    if (result != "") {
      resultData = jsonDecode(result);
      log(resultData.toString());
      image.value = resultData['image_url'];
      arduinoCommands.value = resultData['arduino_commands'];
      hasResult.value = true;
      downloadCodePseudocodeFile();
    }
    super.onInit();
  }
}
