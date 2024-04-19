import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet {
  const CustomBottomSheet({required this.height, required this.body});
  final double height;
  final Widget body;

  static show(double height, Widget body) {
    Get.bottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      Container(height: height, color: Colors.transparent, child: body),
      barrierColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
    );
  }
}
