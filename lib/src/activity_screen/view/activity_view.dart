import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psykitz/src/learning_screen/view/learning_view.dart';
import 'package:sizer/sizer.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_fontsizes.dart';
import '../../activity_identify_symbols_screen/view/activity_identify_symbols_view.dart';
import '../controller/activity_controller.dart';

class ActivityPage extends GetView<ActivityController> {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ActivityController());

    return Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Padding(
            padding: EdgeInsets.only(
              top: 2.h,
            ),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SizedBox(
                      height: 30.h,
                      width: 100.w,
                      child: Image.asset(
                        "assets/images/bluecurve.png",
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                      width: 100.w,
                      child: Image.asset(
                        "assets/images/robot.png",
                      ),
                    ),
                  ],
                ),
                Text(
                  "Flowchart",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSizes.superextraLarge,
                      color: AppColors.lightblue),
                ),
                Text(
                  "Activity",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSizes.superextraLarge,
                      color: AppColors.lightblue),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Expanded(
                    child: Container(
                  width: 100.w,
                  decoration: const BoxDecoration(
                      color: Color(0xff2E99B0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          "Ready to have some fun with Flowcharts? We're going to do a bunch of cool activities to help you understand what Flowcharts are and how they work. Let's get started!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppFontSizes.medium,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        SizedBox(
                          width: 50.w,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.lightyellow,
                              ),
                              onPressed: () {
                                Get.to(() => const LearningPage());
                              },
                              child: Text(
                                "Tutorial",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppFontSizes.medium,
                                  color: AppColors.lightblue,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        SizedBox(
                          width: 50.w,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.lightyellow,
                              ),
                              onPressed: () {
                                Get.to(
                                    () => const ActivityIdentifySymbolsPage());
                              },
                              child: Text(
                                "Ready!",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppFontSizes.medium,
                                  color: AppColors.lightblue,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}
