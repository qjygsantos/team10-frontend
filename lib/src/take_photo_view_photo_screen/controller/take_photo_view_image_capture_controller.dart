import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
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
    var request = http.MultipartRequest('POST', Uri.parse("https://handwritten-flowchart-detection-team10-6jxk.onrender.com/upload"));
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        imageCaptured!.path,
        filename: basename(imageCaptured!.path),
      ),
    );
    http.Response response = await http.Response.fromStream(await request.send());
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
}
