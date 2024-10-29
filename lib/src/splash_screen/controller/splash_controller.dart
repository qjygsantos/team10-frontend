import 'dart:async';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:psykitz/src/welcome_screen/view/welcome_view.dart';

import '../../../services/bluetooth_service.dart';

class SplashController extends GetxController {
  navigateTo() async {
    await Permission.bluetoothConnect.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetooth.request();
    await Permission.location.request();
    await Permission.nearbyWifiDevices.request();
    await Get.putAsync<BluetoothAppService>(() async => BluetoothAppService());
    Timer(const Duration(seconds: 4), () async {
      Get.offAll(() => const WelcomePage());
    });
  }

  @override
  void onInit() async {
    navigateTo();

    super.onInit();
  }
}
