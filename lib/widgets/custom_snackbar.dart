import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  const CustomSnackBar({required this.message});

  final String message;

  static show(String message, {int? seconds, SnackPosition? snackPosition}) {
    Get.rawSnackbar(
      message: message,
      snackPosition: snackPosition ?? SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      duration: Duration(seconds: seconds ?? 3),
      backgroundColor: Colors.red,
      borderRadius: 10,
    );
  }
}

