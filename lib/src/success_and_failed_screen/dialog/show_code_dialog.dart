import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psykitz/config/app_colors.dart';
import 'package:sizer/sizer.dart';
import '../controller/success_and_failed_controller.dart';

class CodeDialog {
  static showCodeDialog() {
    var controller = Get.find<SuccessAndFailedController>();
    Get.dialog(AlertDialog(
      title: const Text(
        "PseudoCode",
        style:
            TextStyle(fontWeight: FontWeight.bold, color: AppColors.lightblue),
      ),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 100.w, child: Text(controller.pseudoCodeText.value))
          ],
        ),
      ),
    ));
  }
}
