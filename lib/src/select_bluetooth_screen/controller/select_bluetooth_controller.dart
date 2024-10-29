import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
// import 'package:psykitz/services/open_bluetooth_setting_dialog.dart';
import 'package:flutter/services.dart';
// import '../../../services/bluetooth_service.dart';

class SelectBluetoothController extends GetxController {
  RxBool isLoading = true.obs;
  RxString macAddressConnected = ''.obs;
  RxList<BluetoothDiscoveryResult> devices = <BluetoothDiscoveryResult>[].obs;
  static const platform = MethodChannel('com.example.psykitz/file_transfer');

  BluetoothConnection? connection;

  StreamSubscription<BluetoothDiscoveryResult>? streamSubscription;
  Future<void> getBluetoothDevices() async {
    isLoading.value = true;
    streamSubscription = FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      devices.add(r);
    });

    streamSubscription!.onDone(() {
      final tempList = devices.map((e) => e.device).toSet();
      devices.retainWhere((x) => tempList.remove(x.device));
      // devices.assignAll(tempDevices);
      isLoading.value = false;
      //Do something when the discovery process ends
      streamSubscription!.cancel();
    });
  }

  // connectToDeviceAndSendMessage({required String address, required String message, required String option}) async {
  //   try {
  //     final String result = await platform.invokeMethod('sendBluetoothMessage', {'deviceAddress': address, 'message': message, 'option': option});
  //     log("RESULT: $result");
  //     log(result);
  //     if (result == "SUCCESS") {
  //       macAddressConnected.value = address;
  //       Get.find<BluetoothAppService>().blueToothAddress = address;
  //       Get.snackbar("Message", "Connected!", backgroundColor: AppColors.lightblue, colorText: Colors.white);
  //     } else {}
  //   } catch (exception) {
  //     log('Cannot connect, exception occured $exception');
  //   }
  // }

  // tesConnection({required String address, required String message, required String option}) async {
  //   try {
  //     final String result = await platform.invokeMethod('sendBluetoothMessage', {'deviceAddress': address, 'message': message, 'option': option});
  //     log("RESULT: $result");
  //     log(result);
  //     if (result == "SUCCESS") {
  //       Get.snackbar("Message", "Connection success!", backgroundColor: AppColors.lightblue, colorText: Colors.white);
  //     } else {
  //       Get.snackbar("Message", "Failed to connect!", backgroundColor: Colors.red, colorText: Colors.white);
  //     }
  //   } catch (exception) {
  //     log('Cannot connect, exception occured $exception');
  //   }
  // }

  // connectToDeviceAndSendArduinoCommands({required String address, required String message, required String option}) async {
  //   try {
  //     final String result = await platform.invokeMethod('sendBluetoothMessage', {'deviceAddress': address, 'message': message, 'option': option});
  //     log("RESULT: $result");
  //     log(result);
  //     if (result == "SUCCESS") {
  //       macAddressConnected.value = address;
  //       Get.find<BluetoothAppService>().blueToothAddress = address;
  //     } else {}
  //   } catch (exception) {
  //     log('Cannot connect, exception occured $exception');
  //   }
  // }

  bluetoothConnect({required String address}) async {
    BluetoothConnection.toAddress(address).then((connections) {
      log('Connected to the device');
      connection = connections;
    }).catchError((error) {
      log('Cannot connect, exception occured');
      log(error.toString());
    });
  }

  sendMessage({required String message}) async {
    if (connection != null) {
      connection!.output.add(Uint8List.fromList(utf8.encode(message)));
      await connection!.output.allSent;
    }
  }

  // @override
  // void onInit() async {
  //   if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
  //     OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
  //   } else {
  //     getBluetoothDevices();
  //   }
  //   super.onInit();
  // }

  @override
  void onClose() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
    super.onClose();
  }
}
