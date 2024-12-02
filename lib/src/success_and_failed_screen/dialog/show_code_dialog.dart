import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psykitz/config/app_colors.dart';
import 'package:psykitz/services/message_dialog.dart';
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
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                    controller.pseudocodeEditor.text = controller.pseudoCodeText.value;
                    Get.to(() => const EditPseudoCodePage());
                  },
                  child: const Icon(Icons.edit)),
              Obx(
                () => controller.isPseudoCodeError.value
                    ? Padding(
                        padding: EdgeInsets.only(left: 1.w),
                        child: GestureDetector(
                            onTap: () {
                              Get.back();
                              MessageDialog.showMessageDialog(message: controller.errorPseudoCodeData.value);
                            },
                            child: const Icon(
                              Icons.bug_report,
                              color: Colors.red,
                            )),
                      )
                    : const SizedBox(),
              ),
            ],
          )
        ],
      ),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => controller.isPseudoCodeError.value
                  ? SizedBox(
                      width: 100.w,
                      child: Column(
                        children: [
                          for (var i = 0; i < controller.pseudoCodeList.length; i++) ...[
                            Container(
                              color: (i + 1) == controller.lineError.value ? Colors.red : null,
                              child: SizedBox(
                                width: 100.w,
                                child: Text(controller.pseudoCodeList[i]),
                              ),
                            ),
                          ]
                        ],
                      ))
                  : SizedBox(
                      width: 100.w,
                      child: Text(controller.pseudoCodeText.value),
                    ),
            ),
          ],
        ),
      ),
    ));
  }
}
