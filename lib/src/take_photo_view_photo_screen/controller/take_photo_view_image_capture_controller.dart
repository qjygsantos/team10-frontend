import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:psykitz/config/app_colors.dart';
import 'package:psykitz/services/message_dialog.dart';

import '../../success_and_failed_screen/view/success_and_failed_view.dart';

class TakePhotoViewImageCaptureController extends GetxController {
  RxString imagePath = ''.obs;
  XFile? imageCaptured;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    imageCaptured = Get.arguments['imageCaptured'];
    if (imageCaptured != null) {
      imagePath.value = imageCaptured!.path;
    }
    super.onInit();
  }

// https://team10-backend.up.railway.app/upload - new endpoint
// https://handwritten-flowchart-detection-team10-6jxk.onrender.com/upload - old endpoint
  Future<void> uploadFile() async {
    isLoading.value = true;
<<<<<<< HEAD
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "https://team10-backend.up.railway.app/upload"));
=======
    var request = http.MultipartRequest('POST', Uri.parse("https://team10-backend.up.railway.app/upload"));
>>>>>>> 4cd84ff3519f4bc2eaf7d82ef055f5b7ff9a03b2
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        imageCaptured!.path,
        filename: basename(imageCaptured!.path),
      ),
    );

    http.Response response = await http.Response.fromStream(await request.send());
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      String res = response.body;
      var result = jsonDecode(res);
      if (result['status'] == "Success") {
        Get.to(() => const SuccessAndFailedPage(), arguments: {"status": "Success", "result": res});
      } else {
        MessageDialog.showMessageDialog(message: result['message']);
      }
    } else {
      String res = response.body;
      var result = jsonDecode(res);
      MessageDialog.showMessageDialog(message: result['message']);
      // Get.to(() => const SuccessAndFailedPage(),
      //     arguments: {"status": "Failed", "result": ""});
    }
    isLoading.value = false;
  }
<<<<<<< HEAD
}
=======

  cropImage({required BuildContext context}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath.value,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.lightblue,
          toolbarWidgetColor: Colors.white,
          cropFrameColor: AppColors.lightblue,
          activeControlsWidgetColor: AppColors.lightblue,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio16x9,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(), // IMPORTANT: iOS supports only one custom aspect ratio in preset list
          ],
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    if (croppedFile != null) {
      log(croppedFile.path);
      imagePath.value = croppedFile.path;
    }
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}
>>>>>>> 4cd84ff3519f4bc2eaf7d82ef055f5b7ff9a03b2
