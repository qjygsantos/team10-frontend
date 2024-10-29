import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ListenToDataController extends GetxController {
  static const eventChannel = EventChannel('bluetoothStream');
  RxString datareceived = ''.obs;

  listenToData() {
    eventChannel
        .receiveBroadcastStream()
        .listen(_onDataReceived, onError: _onError);
  }

  void _onDataReceived(dynamic data) {
    log("Received: $data");
    datareceived.value = data;
  }

  void _onError(dynamic error) {
    log("Error receiving data: ${error.message}");
  }

  @override
  void onInit() {
    listenToData();
    super.onInit();
  }
}
