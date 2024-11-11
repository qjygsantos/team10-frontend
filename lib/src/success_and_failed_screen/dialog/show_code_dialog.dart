import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psykitz/config/app_colors.dart';
import 'package:sizer/sizer.dart';
import '../controller/success_and_failed_controller.dart';
import '../view/edit_pseudocode_view.dart';

class CodeDialog {
  static showCodeDialog() {
    var controller = Get.find<SuccessAndFailedController>();
    Get.dialog(AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "PseudoCode",
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.lightblue),
          ),
          GestureDetector(
              onTap: () {
                Get.back();
                controller.pseudocodeEditor.text = controller.pseudoCodeText.value;
                Get.to(() => const EditPseudoCodePage());
              },
              child: const Icon(Icons.edit))
        ],
      ),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [SizedBox(width: 100.w, child: Text(controller.pseudoCodeText.value))],
        ),
      ),
    ));
  }
}
