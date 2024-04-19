import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//Utility class for CachedNetworkImage library
class CachedNetworkImageUtil extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double scale;
  final BoxFit? boxFit;
  final Alignment? alignment;
  final Widget? errorWidget;

  const CachedNetworkImageUtil(
      {Key? key,
      required this.imageUrl,
      required this.height,
      this.boxFit = BoxFit.fill,
      this.errorWidget,
      this.alignment,
      required this.width,
      required this.scale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: boxFit,
      filterQuality: FilterQuality.high,
      colorBlendMode: BlendMode.srcATop,
      memCacheHeight: height.toInt(),
      color: Colors.transparent,
      alignment: alignment ?? Alignment.center,
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
            value: downloadProgress.progress,
            color: Colors.blueAccent,
            strokeWidth: 2.0),
      ),
      /* errorWidget: (context, url, error) =>
            ColorFiltered(colorFilter: greyscale, child: errorWidget),*/
    );
  }
}
