import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_fontsizes.dart';
import '../../../model/symbols_model.dart';
import '../../../services/diamond_shape_service.dart';
import '../controller/activity_arrange_symbols_controller.dart';

class ActivityArrangeSymbolsPage
    extends GetView<ActivityArrangeSymbolsController> {
  const ActivityArrangeSymbolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ActivityArrangeSymbolsController());
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightyellow,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {
                  controller.resetGame();
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
          height: 100.h,
          width: 100.w,
          child: Padding(
            padding: EdgeInsets.only(
              left: 5.w,
              right: 5.w,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 100.w,
                  child: Text(
                    "Arrange the\nFlowchart in Order:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppFontSizes.extraLarge,
                        color: AppColors.lightblue),
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  child: Text(
                    "Order: Start -> Decision -> Process -> Data -> End",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: AppFontSizes.small,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 40.h,
                  width: 100.w,
                  child: Card(
                    color: AppColors.lightblue,
                    child: Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: Obx(
                        () => ListView.builder(
                          itemCount: controller.symbolsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return controller.symbolsList[index].answer ==
                                    "Decision"
                                ? GestureDetector(
                                    onTap: () {
                                      controller.symbolsList.removeAt(index);
                                    },
                                    child: Center(
                                      child: SizedBox(
                                        height: 5.h,
                                        width: 23.w,
                                        child: DiamondContainer(
                                          color: AppColors.lightyellow,
                                          height: 5.h,
                                          width: 23.w,
                                        ),
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      controller.symbolsList.removeAt(index);
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: controller.symbolsList[index]
                                                      .answer ==
                                                  "Arrow"
                                              ? 2.h
                                              : 4.h,
                                          width: 23.w,
                                          child: Image.asset(
                                            controller
                                                .symbolsList[index].assets,
                                            color: AppColors.lightyellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (controller.symbolsList.length < 9) {
                          controller.symbolsList.add(SymbolsModel(
                              assets: "assets/images/shapes/oblong.png",
                              answer: "Start",
                              isCorrect: "".obs));
                        }
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                            width: 23.w,
                            child: Image.asset(
                              "assets/images/shapes/oblong.png",
                              color: AppColors.lightyellow,
                            ),
                          ),
                          // Text(
                          //   "Start/End",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: AppFontSizes.medium,
                          //       color: AppColors.lightblue),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.symbolsList.length < 9) {
                          controller.symbolsList.add(SymbolsModel(
                              assets: "assets/images/shapes/arrowdown.png",
                              answer: "Arrow",
                              isCorrect: "".obs));
                        }
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                            width: 23.w,
                            child: Image.asset(
                              "assets/images/shapes/arrow.png",
                              color: AppColors.lightyellow,
                            ),
                          ),
                          // Text(
                          //   "Arrow",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: AppFontSizes.medium,
                          //       color: AppColors.lightblue),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.symbolsList.length < 9) {
                          controller.symbolsList.add(SymbolsModel(
                              assets:
                                  "assets/images/shapes/diagonalrectangle.png",
                              answer: "Data",
                              isCorrect: "".obs));
                        }
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                            width: 23.w,
                            child: Image.asset(
                              "assets/images/shapes/diagonalrectangle.png",
                              color: AppColors.lightyellow,
                            ),
                          ),
                          // Text(
                          //   "Data",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: AppFontSizes.medium,
                          //       color: AppColors.lightblue),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (controller.symbolsList.length < 9) {
                            controller.symbolsList.add(SymbolsModel(
                                assets: "assets/images/shapes/diamond.png",
                                answer: "Decision",
                                isCorrect: "".obs));
                          }
                        },
                        child: Column(
                          children: [
                            DiamondContainer(
                              color: AppColors.lightyellow,
                              height: 5.h,
                              width: 23.w,
                            ),
                            // Text(
                            //   "Decision",
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: AppFontSizes.medium,
                            //       color: AppColors.lightblue),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (controller.symbolsList.length < 9) {
                            controller.symbolsList.add(SymbolsModel(
                                assets: "assets/images/shapes/rectangle.png",
                                answer: "Process",
                                isCorrect: "".obs));
                          }
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5.h,
                              width: 23.w,
                              child: Image.asset(
                                "assets/images/shapes/rectangle.png",
                                color: AppColors.lightyellow,
                              ),
                            ),
                            // Text(
                            //   "Process",
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: AppFontSizes.medium,
                            //       color: AppColors.lightblue),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                SizedBox(
                  height: 7.h,
                  width: 100.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightyellow,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      controller.checkAnswer();
                    },
                    child: Text(
                      "Check",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppFontSizes.medium,
                          color: AppColors.lightblue),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                )
              ],
            ),
          ),
        ));
  }
}
