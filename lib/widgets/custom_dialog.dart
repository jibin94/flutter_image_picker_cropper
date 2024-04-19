import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialogueBox {
  const CustomDialogueBox({
    required this.message,
    required this.backgroundColor,
    required this.singleButtonText,
    required this.singleButtonColor,
  });

  final String message;
  final Color backgroundColor;
  final String singleButtonText;
  final Color singleButtonColor;

  static show(
    String message,
    Color backgroundColor,
    String singleButtonText,
    Color singleButtonColor,
    Function() actionConfirmed,
  ) {
    Get.defaultDialog(
        content: Container(
          color: backgroundColor,
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(Get.context!).size.width * 0.01),
                child: Text(message, textAlign: TextAlign.center),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        contentPadding: const EdgeInsets.only(bottom: 15),
        titlePadding: const EdgeInsets.only(top: 0),
        title: "",
        confirm: TextButton(
          onPressed: actionConfirmed,
          style: TextButton.styleFrom(
            // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: singleButtonColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(singleButtonText),
        ),
        backgroundColor: backgroundColor,
        radius: 8);
  }
}
