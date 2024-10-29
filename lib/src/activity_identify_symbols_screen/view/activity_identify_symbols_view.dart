import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psykitz/config/app_colors.dart';
import 'package:psykitz/src/activity_arrange_symbols_screen/view/activity_arrange_symbols_view.dart';
import 'package:sizer/sizer.dart';
import '../../../config/app_fontsizes.dart';
import '../../../services/diamond_shape_service.dart';
import '../controller/activity_identify_symbols_controller.dart';

class ActivityIdentifySymbolsPage
    extends GetView<ActivityIdentifySymbolsController> {
  const ActivityIdentifySymbolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ActivityIdentifySymbolsController());

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightyellow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                controller.reset();
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.refresh,
                    color: AppColors.lightblue,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    "Reset",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppFontSizes.medium,
                        color: AppColors.lightblue),
                  ),
                ],
              )),
          SizedBox(
            width: 5.w,
          ),
        ],
      ),
      body: SizedBox(
        width: 100.w,
        child: Padding(
          padding: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 100.w,
                  child: Text(
                    "Identify Symbols:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppFontSizes.superextraLarge,
                        color: AppColors.lightblue),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "1.) ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppFontSizes.medium,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Container(
                          height: 5.h,
                          width: 40.w,
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide())),
                          child: TextField(
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSizes.medium),
                            controller: controller.controllerSymbol1,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Obx(() => controller.isCorrect1.value == "Correct"
                            ? const Icon(Icons.check, color: Colors.green)
                            : controller.isCorrect1.value == "Wrong"
                                ? const Icon(Icons.clear, color: Colors.red)
                                : const SizedBox())
                      ],
                    ),
                    SizedBox(
                      height: 7.h,
                      width: 29.w,
                      child: Image.asset(
                        "assets/images/shapes/oblong.png",
                        color: AppColors.lightblue,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "2.) ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppFontSizes.medium,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Container(
                          height: 5.h,
                          width: 40.w,
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide())),
                          child: TextField(
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSizes.medium),
                            controller: controller.controllerSymbol2,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Obx(() => controller.isCorrect2.value == "Correct"
                            ? const Icon(Icons.check, color: Colors.green)
                            : controller.isCorrect2.value == "Wrong"
                                ? const Icon(Icons.clear, color: Colors.red)
                                : const SizedBox())
                      ],
                    ),
                    DiamondContainer(
                      color: AppColors.lightblue,
                      height: 7.h,
                      width: 29.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "3.) ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppFontSizes.medium,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Container(
                          height: 5.h,
                          width: 40.w,
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide())),
                          child: TextField(
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSizes.medium),
                            controller: controller.controllerSymbol3,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Obx(() => controller.isCorrect3.value == "Correct"
                            ? const Icon(Icons.check, color: Colors.green)
                            : controller.isCorrect3.value == "Wrong"
                                ? const Icon(Icons.clear, color: Colors.red)
                                : const SizedBox())
                      ],
                    ),
                    SizedBox(
                      height: 7.h,
                      width: 29.w,
                      child: Image.asset(
                        "assets/images/shapes/arrow.png",
                        color: AppColors.lightblue,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "4.) ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppFontSizes.medium,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Container(
                          height: 5.h,
                          width: 40.w,
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide())),
                          child: TextField(
                            controller: controller.controllerSymbol4,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSizes.medium),
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Obx(() => controller.isCorrect4.value == "Correct"
                            ? const Icon(Icons.check, color: Colors.green)
                            : controller.isCorrect4.value == "Wrong"
                                ? const Icon(Icons.clear, color: Colors.red)
                                : const SizedBox())
                      ],
                    ),
                    SizedBox(
                      height: 7.h,
                      width: 29.w,
                      child: Image.asset(
                        "assets/images/shapes/rectangle.png",
                        color: AppColors.lightblue,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "5.) ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppFontSizes.medium,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Container(
                          height: 5.h,
                          width: 40.w,
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide())),
                          child: TextField(
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSizes.medium),
                            controller: controller.controllerSymbol5,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Obx(() => controller.isCorrect5.value == "Correct"
                            ? const Icon(Icons.check, color: Colors.green)
                            : controller.isCorrect5.value == "Wrong"
                                ? const Icon(Icons.clear, color: Colors.red)
                                : const SizedBox())
                      ],
                    ),
                    SizedBox(
                      height: 7.h,
                      width: 29.w,
                      child: Image.asset(
                        "assets/images/shapes/diagonalrectangle.png",
                        color: AppColors.lightblue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.lightyellow,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          extendedPadding: EdgeInsets.only(left: 15.w, right: 15.w),
          onPressed: () {
            if (controller.isChecked.value) {
              Get.to(() => const ActivityArrangeSymbolsPage());
            } else {
              controller.checkAnswer();
            }
          },
          label: Obx(
            () => Text(
              controller.isChecked.value == false ? "Check" : "Done",
              style: TextStyle(
                  color: AppColors.lightblue,
                  fontSize: AppFontSizes.medium,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
