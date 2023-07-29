import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ZoomDrawing extends StatelessWidget {
  final String imageUrl;
  const ZoomDrawing({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => Center(
            child: SizedBox(
                height: 5.h,
                width: 5.h,
                child: const CircularProgressIndicator(color: Colors.black))),
        fit: BoxFit.contain,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
