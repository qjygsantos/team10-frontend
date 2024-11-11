import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psykitz/config/app_fontsizes.dart';
import 'package:psykitz/services/bluetooth_service.dart';
import 'package:sizer/sizer.dart';
import '../../../config/app_colors.dart';
import '../../../services/open_bluetooth_setting_dialog.dart';
import '../../home_screen/view/home_view.dart';
import '../controller/welcome_controller.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WelcomeController());
    return Scaffold(
        body: Container(
      height: 100.h,
      width: 100.w,
      decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/homeimage.png"))),
      child: Padding(
        padding: EdgeInsets.only(top: 7.h, left: 5.w, right: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.superextraLarge, color: AppColors.lightblue),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Dive in",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.beyondExtraLarge, color: AppColors.lightblue),
            ),
            Text(
              "and bring",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.beyondExtraLarge, color: AppColors.lightblue),
            ),
            Text(
              "your ideas",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.beyondExtraLarge, color: AppColors.lightblue),
            ),
            Text(
              "to life! 🤖",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.beyondExtraLarge, color: AppColors.lightblue),
            ),
            SizedBox(
              height: 4.h,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w),
                  backgroundColor: AppColors.lightblue,
                ),
                onPressed: () async {
                  if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                    OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                  } else {
                    // Get.offAll(() => const SelectBluetoothPage());
                    Get.offAll(() => const HomePage());
                  }
                  // Get.offAll(() => const HomePage());
                },
                child: Text(
                  "Continue",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.medium, color: Colors.white),
                ))
          ],
        ),
      ),
    ));
  }
}
