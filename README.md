## Plugins Used
- [image_picker](https://pub.dev/packages/image_picker) : This plugin allows users to pick images from their mobile device's gallery or camera.
- [image_cropper](https://pub.dev/packages/image_cropper) : After selecting an image, users can crop and rotate it using this plugin. It's commonly used in applications where the image format or size needs to be adjusted, such as cropping a photo to fit a profile picture area.
- [device_info_plus](https://pub.dev/packages/device_info_plus) : Get current device information from within the Flutter application
- [get](https://pub.dev/packages/get) : Get is a state management solution, but also offers utilities for route management, dependency injection, and snackbar/toast notifications, making it very versatile.
- [permission_handler](https://pub.dev/packages/permission_handler) : Manages permission requests for features that require explicit user approval, such as GPS, camera access, and more.
- [cached_network_image](https://pub.dev/packages/cached_network_image) : Efficiently loads and caches images from the internet, which can then be displayed even when offline.

## User Experience and Interaction Flow
* User taps on upload icon: This initiates the image selection process.
* CustomBottomSheet appears: Offers user options to pick or capture an image.
* User selects/captures and crops an image: Using tools provided by CameraGalleryHelper and possibly image_cropper.
* Image is processed and returned: The selected image is cropped and processed, then passed back via the photoObject callback.
* State update in EditProfileController: The new image data is set in the controller, updating the UI reactively.