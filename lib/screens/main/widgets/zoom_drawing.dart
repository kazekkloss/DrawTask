import 'package:cached_network_image/cached_network_image.dart';
import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ZoomDrawing extends StatelessWidget {
  final bool zoom;
  final String imageUrl;
  final VoidCallback onTap;
  const ZoomDrawing(
      {super.key,
      required this.zoom,
      required this.imageUrl,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      //top: zoom ? 0 : 10.3.h,
      right: zoom ? 0 : 0,
      curve: Curves.linearToEaseOut,
      duration: const Duration(milliseconds: 400),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            height: 100.h,
            width: 100.w,
            color: Color.fromARGB(255, 255, 255, 255),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )),
      ),
    );
  }
}
