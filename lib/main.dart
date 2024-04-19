import 'package:flutter/material.dart';
import 'package:flutter_image_picker_cropper/utils/routes.dart';
import 'package:flutter_image_picker_cropper/view/edit_image/binding/edit_team_details_binding.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.initial,
      getPages: appPages,
      initialBinding: EditProfileBinding(),
    );
  }
}
