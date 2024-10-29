import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/listen_to_data_controller.dart';

class ListenToDataPage extends GetView<ListenToDataController> {
  const ListenToDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ListenToDataController());
    return Scaffold(
        body: SafeArea(
            child:
                Center(child: Obx(() => Text(controller.datareceived.value)))));
  }
}
