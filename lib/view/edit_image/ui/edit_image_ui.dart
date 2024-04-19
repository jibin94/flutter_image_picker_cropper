import 'package:flutter/material.dart';
import 'package:flutter_image_picker_cropper/widgets/custom_bottom_sheet.dart';
import 'package:flutter_image_picker_cropper/widgets/image_widget.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../utils/camera_helper.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileUI extends GetView<EditProfileController> {
  const EditProfileUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Flutter Image", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(
        () => controller.isPageLoading.value
            ? const CircularProgressIndicator()
            : bodyContainer(),
      ),
    );
  }

  Widget bodyContainer() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 1, color: Colors.black),
              color: Colors.white,
            ),
            child: Obx(
              () => ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                child: Stack(
                  children: [
                    ProfileImageWidget(
                      path: controller.imagePath.value,
                      aspectRatio: 16 / 9,
                      title: "Upload Image",
                    ),
                    Positioned(
                      bottom: 5,
                      right: 12,
                      child: InkWell(
                        onTap: () => CustomBottomSheet.show(
                          MediaQuery.of(Get.context!).size.height * 0.2,
                          CameraGalleryHelper(
                            cropperType: CropperType.image.name,
                            photoObject: (CroppedFile croppedFile) {
                              debugPrint("camera image picked");
                              Get.back();
                              controller.setImage(
                                  UploadImageType.image.name, croppedFile);
                            },
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: const Icon(
                            Icons.upload,
                            color: Colors.black,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 1, color: Colors.black),
              color: Colors.white,
            ),
            child: Obx(
              () => ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 150,
                      child: ProfileImageWidget(
                        path: controller.logoPath.value,
                        aspectRatio: 1 / 1,
                        title: "Upload Logo",
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 12,
                      child: InkWell(
                        onTap: () => CustomBottomSheet.show(
                          MediaQuery.of(Get.context!).size.height * 0.2,
                          CameraGalleryHelper(
                            cropperType: CropperType.logo.name,
                            photoObject: (CroppedFile foo) {
                              debugPrint("camera image picked");
                              Get.back();
                              controller.setImage(
                                  UploadImageType.logo.name, foo);
                            },
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: const Icon(
                            Icons.upload,
                            color: Colors.black,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
