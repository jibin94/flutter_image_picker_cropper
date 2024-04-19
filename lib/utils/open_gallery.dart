import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_picker_cropper/utils/app_strings.dart';
import 'package:flutter_image_picker_cropper/utils/camera_helper.dart';
import 'package:flutter_image_picker_cropper/widgets/custom_dialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Gallery {
  /// Open image gallery and pick an image,Will not work on stimulators
  static Future<XFile?> askGalleryPickerPermission() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      int version = int.parse(release);

      /// debugPrint("version : $version");
      /// Android 9
      /// When running on Android < T: No permission needed
      if (version > 12) {
        return await pickImageFromGallery();
      } else {
        return await ImagePicker().pickImage(source: ImageSource.gallery);
      }
    } else if (Platform.isIOS) {
      return await pickImageFromGallery();
    }
    return null;
  }

  static Future<XFile?> pickImageFromGallery() async {
    var status = await Permission.photos.request();
    if (status.isGranted || status.isLimited) {
      return await ImagePicker().pickImage(source: ImageSource.gallery);
    } else if (status.isPermanentlyDenied || status.isDenied) {
      CustomDialogueBox.show(AppStrings.galleryPermissionMessage, Colors.red,
          AppStrings.goToSettings, Colors.white, () async {
        if (Platform.isAndroid || Platform.isIOS) {
          await openAppSettings();
        }
      });
    }
    return null;
  }
}

class Camera {
  /// Open camera and crop image based on cropping type,Will not work on simulators
  static Future<CroppedFile?> profileCropper(String cropperType) async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);

      ///if cropper type is for team profile, crop captured image in 16:9 aspect ratio
      ///else crop in 1:1 ratio
      if (cropperType == CropperType.image.name) {
        return Cropper.teamProfileCropper(file);
      } else {
        return Cropper.oneToOneCropper(file);
      }
    } else if (status.isPermanentlyDenied || status.isDenied) {
      CustomDialogueBox.show(AppStrings.cameraPermissionMessage, Colors.red,
          AppStrings.goToSettings, Colors.white, () async {
        if (Platform.isAndroid || Platform.isIOS) {
          await openAppSettings();
        }
      });
    }
    return null;
  }
}

class Cropper {
  /// Crop image in 1:1 size,Will not work on simulators
  static Future<CroppedFile?> oneToOneCropper(XFile? filePath) async {
    return await ImageCropper().cropImage(
      sourcePath: filePath!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: AppStrings.imageCropper,
            toolbarColor: Colors.blueAccent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
            title: AppStrings.imageCropper,
            aspectRatioLockEnabled: true,
            minimumAspectRatio: 1.0,
            resetButtonHidden: true),
      ],
    );
  }

  /// Crop image in 16:9 size,Will not work on simulators
  static Future<CroppedFile?> teamProfileCropper(XFile? file) async {
    return await ImageCropper().cropImage(
      sourcePath: file!.path,
      aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: AppStrings.imageCropper,
            toolbarColor: Colors.blueAccent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
            title: AppStrings.imageCropper,
            aspectRatioLockEnabled: true,
            minimumAspectRatio: 16 / 9,
            resetButtonHidden: true),
      ],
    );
  }
}
