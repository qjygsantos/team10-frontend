import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psykitz/src/activity_arrange_symbols_screen/controller/activity_arrange_symbols_controller.dart';
import 'package:psykitz/src/home_screen/view/home_view.dart';
import 'package:sizer/sizer.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_fontsizes.dart';

class ActivityArrangeSymbolsWidget {
  static showResult() {
    var controller = Get.find<ActivityArrangeSymbolsController>();
    Get.dialog(AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 100.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                controller.percentDouble.value > 79
                    ? "CONGRATULATIONS!"
                    : "RESULT",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSizes.large,
                    color: AppColors.lightblue),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Stack(
              children: [
                SizedBox(
                  child: Image.asset(
                    "assets/images/robot.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16.h,
                  left: 40.w,
                  child: SizedBox(
                    child: Image.asset(
                      "assets/images/medal.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "You've scored ${controller.percentage.value} %",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSizes.medium,
                  color: AppColors.lightblue),
            ),
            Obx(
              () => Text(
                controller.percentDouble.value > 79
                    ? "Keep up the good work"
                    : "Better luck next time",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSizes.regular,
                    color: AppColors.lightblue),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              width: 60.w,
              height: 7.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightyellow,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {
                  Get.back();
                  controller.resetGame();
                },
                child: Text(
                  "Try Again",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSizes.medium,
                      color: AppColors.lightblue),
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              width: 60.w,
              height: 7.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightyellow,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {
                  Get.offAll(() => const HomePage());
                },
                child: Text(
                  "Back to Home",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSizes.medium,
                      color: AppColors.lightblue),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
