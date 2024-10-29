import 'package:get/get.dart';
import 'package:psykitz/services/bluetooth_service.dart';
import 'package:psykitz/services/open_bluetooth_setting_dialog.dart';

class WelcomeController extends GetxController {
  @override
  void onReady() async {
    if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
      OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
    }
    super.onReady();
  }
}
