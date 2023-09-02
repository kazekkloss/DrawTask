import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DrawingTab extends StatelessWidget {
  final String imageUrl;
  const DrawingTab({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84.6.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0).withOpacity(1),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: -3,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => Center(
              child: SizedBox(
            width: 84.6.w,
            height: 84.6.w,
            child: Center(
              child: SizedBox(
                  height: 5.h,
                  width: 5.h,
                  child: const CircularProgressIndicator(color: Colors.black)),
            ),
          )),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
