import 'package:get/get.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileBinding implements Bindings {
  EditProfileBinding();

  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}
