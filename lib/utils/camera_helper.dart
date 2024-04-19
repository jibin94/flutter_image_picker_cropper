import 'package:flutter/material.dart';
import 'package:flutter_image_picker_cropper/widgets/custom_snackbar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'open_gallery.dart';

typedef PhotoCallback = void Function(CroppedFile foo);

enum CropperType { image, logo }

class CameraGalleryHelper extends StatelessWidget {
  final PhotoCallback photoObject;
  final String cropperType;
  const CameraGalleryHelper(
      {Key? key, required this.photoObject, required this.cropperType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        color: Colors.white10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => openCameraFromDevice(cropperType).then((photo) {
                  if (photo == null) {
                    return;
                  } else {
                    photoObject(photo);
                  }
                }),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                      size: MediaQuery.of(context).size.height * 0.08,
                    ),
                    const Text(
                      "Camera",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => openGalleryFromDevice(cropperType).then((photo) {
                  if (photo == null) {
                    return;
                  } else {
                    photoObject(photo);
                  }
                }),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      color: Colors.black,
                      size: MediaQuery.of(context).size.height * 0.08,
                    ),
                    const Text(
                      "Gallery",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              "Allowed formats are .jpeg, .jpg, .png. Image size should not exceed 20MB.",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

Future<CroppedFile?> openGalleryFromDevice(type) async {
  CroppedFile? file;
  // Step #1: Pick Image From Gallery.
  await Gallery.askGalleryPickerPermission().then((pickedFile) async {
    // Step #2: Check if we actually picked an image. Otherwise -> stop;
    if (pickedFile == null) return;
    if (type == CropperType.logo.name) {
      file = await Cropper.oneToOneCropper(pickedFile);
    } else {
      file = await Cropper.teamProfileCropper(pickedFile);
    }
    final double imageSize = file!.path.length / (1024 * 1024); // Size in MB
    if (imageSize > 20) {
      CustomSnackBar.show('Image size should be less than 20MB.');
      return;
    }
  });
  return file;
}

Future<CroppedFile?> openCameraFromDevice(String cropperType) async {
  CroppedFile? file;
  // Step #1: Pick Image From Gallery.
  await Camera.profileCropper(cropperType).then((pickedFile) async {
    // Step #2: Check if we actually picked an image. Otherwise -> stop;
    if (pickedFile == null) {
      return;
    } else {
      file = pickedFile;
      final double imageSize = file!.path.length / (1024 * 1024); // Size in MB
      if (imageSize > 20) {
        CustomSnackBar.show('Image size should be less than 20MB');
        return;
      }
    }
  });
  return file;
}
