import 'dart:io';
import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  final String? path;
  final double? aspectRatio;
  final String? title;
  const ProfileImageWidget({
    required this.path,
    required this.aspectRatio,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: (path != null && path != "")
          ? AspectRatio(
              aspectRatio: aspectRatio!,
              child: Image.file(
                File(path!),
                fit: BoxFit.contain,
                width: aspectRatio != 16 / 9 ? 150 : double.infinity,
              ),
            )
          : Container(
              width: aspectRatio != 16 / 9 ? 150 : double.infinity,
              height: 150,
              decoration: const BoxDecoration(color: Colors.white70),
              child: Center(
                child: Text(
                  title!,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
    );
  }
}

bool isValidURL(String url) {
  return Uri.parse(url).isAbsolute;
}
