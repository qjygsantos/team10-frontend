import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_fontsizes.dart';
import '../../../services/diamond_shape_service.dart';
import '../controller/learning_controller.dart';

class LearningPage extends GetView<LearningController> {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LearningController());

    return Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          child: Padding(
            padding: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Flowchart",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppFontSizes.superextraLarge,
                        color: AppColors.lightblue),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 25.h,
                    width: 100.w,
                    child: Card(
                      color: AppColors.lightblue,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 3.w, right: 3.w, top: 2.h),
                        child: Text(
                          "A flowchart is a visual representation that allows you to comprehend and follow a process step by step. It employs numerous forms, including as rectangles, diamonds, and arrows, to depict various actions, choices, and process flows.",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: AppFontSizes.regular),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Flowchart Symbols",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppFontSizes.superextraLarge,
                        color: AppColors.lightblue),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 7.h,
                            width: 29.w,
                            child: Image.asset(
                              "assets/images/shapes/oblong.png",
                              color: AppColors.lightyellow,
                            ),
                          ),
                          Text(
                            "Start/End",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSizes.medium,
                                color: AppColors.lightblue),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 7.h,
                            width: 29.w,
                            child: Image.asset(
                              "assets/images/shapes/arrow.png",
                              color: AppColors.lightyellow,
                            ),
                          ),
                          Text(
                            "Arrow",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSizes.medium,
                                color: AppColors.lightblue),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 7.h,
                            width: 29.w,
                            child: Image.asset(
                              "assets/images/shapes/diagonalrectangle.png",
                              color: AppColors.lightyellow,
                            ),
                          ),
                          Text(
                            "Data",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSizes.medium,
                                color: AppColors.lightblue),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          DiamondContainer(
                            color: AppColors.lightyellow,
                            height: 7.h,
                            width: 29.w,
                          ),
                          Text(
                            "Start/End",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSizes.medium,
                                color: AppColors.lightblue),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 7.h,
                            width: 29.w,
                            child: Image.asset(
                              "assets/images/shapes/rectangle.png",
                              color: AppColors.lightyellow,
                            ),
                          ),
                          Text(
                            "Process",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSizes.medium,
                                color: AppColors.lightblue),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "How to use a \nflowchart",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppFontSizes.superextraLarge,
                        color: AppColors.lightblue),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 25.h,
                    width: 100.w,
                    color: Colors.black,
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
