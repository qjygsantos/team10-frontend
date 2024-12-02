import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../../services/message_dialog.dart';

class SuccessAndFailedController extends GetxController {
  RxString status = ''.obs;
  String result = '';
  Map resultData = {};
  RxBool hasResult = false.obs;
  RxString image = ''.obs;
  RxBool isLoading = true.obs;
  RxString pseudoCodeText = ''.obs;
  RxString arduinoCommands = ''.obs;
  RxString errorData = ''.obs;
  RxString errorPseudoCodeData = ''.obs;
  RxBool isPseudoCodeError = false.obs;
  RxInt lineError = 0.obs;

  TextEditingController pseudocodeEditor = TextEditingController();

  RxList<String> pseudoCodeList = <String>[].obs;

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
          pseudoCodeSetToList(pseudocode: pseudoCodeText.value);
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

  Future<void> sendEditedPseudoCode() async {
    try {
      isLoading.value = true;
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.txt';
      final file = File(filePath);
      await file.writeAsString(pseudocodeEditor.text);
      log(file.path);
      var request = http.MultipartRequest('POST', Uri.parse("https://team10-backend.up.railway.app/translate_pseudocode_from_file"));
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
          filename: basename(file.path),
        ),
      );
      http.Response response = await http.Response.fromStream(await request.send());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        String res = response.body;
        var result = jsonDecode(res);
        log(result.toString());
        arduinoCommands.value = result['arduino_commands'];
        pseudoCodeText.value = pseudocodeEditor.text;
        pseudoCodeSetToList(pseudocode: pseudoCodeText.value);
        if (result['status'] == "Failed") {
          isPseudoCodeError.value = true;
          errorPseudoCodeData.value = result['error_list'];
          lineError.value = result['line_with_error'];
          Get.back();
          MessageDialog.showMessageDialog(message: 'There is something wrong. Please click the pseudo code icon for more details.');
        } else {
          Get.back();
          isPseudoCodeError.value = false;
        }
      } else {
        MessageDialog.showMessageDialog(message: "Failed");
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log("ERROR (sendEditedPseudoCode) $e");
    }
  }

  Future<void> checkPseudoCode({required String pseudocode}) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.txt';
      final file = File(filePath);
      await file.writeAsString(pseudocodeEditor.text);
      log(file.path);
      var request = http.MultipartRequest('POST', Uri.parse("https://team10-backend.up.railway.app/translate_pseudocode_from_file"));
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
          filename: basename(file.path),
        ),
      );
      http.Response response = await http.Response.fromStream(await request.send());
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['status'] == "Failed") {
          isPseudoCodeError.value = true;
          errorPseudoCodeData.value = result['error_list'];
          lineError.value = result['line_with_error'];
          pseudoCodeSetToList(pseudocode: pseudoCodeText.value);
        } else {
          isPseudoCodeError.value = false;
        }
      } else {
        isPseudoCodeError.value = true;
      }
    } catch (e) {
      log("ERROR (checkPseudoCode) $e");
    }
  }

  pseudoCodeSetToList({required String pseudocode}) async {
    List<String> resultList = pseudocode.split("\n");
    pseudoCodeList.assignAll(resultList);
    log(pseudoCodeList.toString());
  }

  @override
  void onReady() async {
    status.value = Get.arguments['status'];
    result = await Get.arguments['result'];
    if (result != "") {
      resultData = jsonDecode(result);
      log(resultData.toString());
      image.value = resultData['image_url'];
      arduinoCommands.value = resultData['arduino_commands'];
      hasResult.value = true;
      if (status.value == "Success") {
        await downloadCodePseudocodeFile();
      } else {
        errorData.value = resultData['error_list'];
        MessageDialog.showMessageDialog(message: "There is something wrong. Click the error bug icon for more details");
        checkPseudoCode(pseudocode: arduinoCommands.value);
        pseudoCodeSetToList(pseudocode: pseudoCodeText.value);
      }
    }
    isLoading.value = false;
    super.onReady();
  }
}
