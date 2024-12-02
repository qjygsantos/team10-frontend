import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:psykitz/config/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badge;
import '../../../services/message_dialog.dart';
import '../controller/success_and_failed_controller.dart';

class EditPseudoCodePage extends GetView<SuccessAndFailedController> {
  const EditPseudoCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Pseudo Code'),
        actions: [
          IconButton(
              onPressed: () {
                MessageDialog.showMessageDialog(message: controller.isPseudoCodeError.value ? controller.errorPseudoCodeData.value : "No errors found");
              },
              icon: Obx(
                () => badge.Badge(
                  showBadge: controller.isPseudoCodeError.value,
                  badgeStyle: const badge.BadgeStyle(badgeColor: Colors.red),
                  badgeContent: const Text("!"),
                  child: const Icon(
                    Icons.bug_report,
                    color: AppColors.lightblue,
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: GestureDetector(
              onTap: () {
                controller.sendEditedPseudoCode();
              },
              child: const Icon(Icons.done),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: SpinKitThreeBounce(
                    color: AppColors.lightblue,
                    size: 30.sp,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 3.h),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: TextField(
                      controller: controller.pseudocodeEditor,
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 3.w, top: 1.h),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
