import 'dart:async';
import 'dart:developer';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

class BluetoothAppService extends GetxService {
  Future<bool> checkBlueToothEnabled() async {
    bool result = true;
    bool? isEnabled = await FlutterBluetoothSerial.instance.isEnabled;
    if (isEnabled != null) {
      result = isEnabled;
    } else {
      result = false;
    }
    log(result.toString());
    return result;
  }
}
