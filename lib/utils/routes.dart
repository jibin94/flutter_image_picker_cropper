import 'package:flutter_image_picker_cropper/view/edit_image/binding/edit_team_details_binding.dart';
import 'package:flutter_image_picker_cropper/view/edit_image/ui/edit_image_ui.dart';
import 'package:get/get.dart';

class Routes {
  static const String initial = '/';
}

//configuration for routes used in app
final List<GetPage> appPages = [
  GetPage(
      name: Routes.initial,
      page: () => const EditProfileUI(),
      binding: EditProfileBinding()),
];
