import 'package:get/get.dart';
import '../../../utils/camera_helper.dart';

enum UploadImageType { image, logo }

class EditProfileController extends GetxController {
  var logoPath = ''.obs;
  var imagePath = ''.obs;
  var isPageLoading = false.obs;

  void openGallery(String uploadType, String cropperType) async {
    await openGalleryFromDevice(cropperType).then(
      (photo) {
        if (photo != null) {
          setImage(uploadType, photo);
        } else {
          return;
        }
      },
    );
  }

  Future<void> setImage(type, photo) async {
    if (type == UploadImageType.image.name) {
      imagePath.value = photo.path;
    } else {
      logoPath.value = photo.path;
    }
    refresh();
  }
}
