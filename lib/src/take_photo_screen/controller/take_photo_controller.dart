import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:psykitz/src/take_photo_view_photo_screen/view/take_photo_view_image_capture_view.dart';

class TakePhotoController extends GetxController {
  XFile? capturedPhoto;
  takePhotoFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      capturedPhoto = photo;
      Get.to(() => const TakePhotoViewImageCapturePage(), arguments: {"imageCaptured": capturedPhoto});
    }
  }

  takePhotoFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      capturedPhoto = photo;
      Get.to(() => const TakePhotoViewImageCapturePage(), arguments: {"imageCaptured": capturedPhoto});
    }
  }
}