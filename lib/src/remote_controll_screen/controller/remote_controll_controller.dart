import 'dart:developer';
import 'package:get/get.dart';

class RemoteControllController extends GetxController {
  triggerArrow({required String address, required String message}) async {
    try {} catch (exception) {
      log('Cannot connect, exception occured $exception');
    }
  }
}
