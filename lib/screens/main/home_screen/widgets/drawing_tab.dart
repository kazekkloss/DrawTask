import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../models/models.dart';

class DrawingTab extends StatelessWidget {
  final Drawing drawing;
  const DrawingTab({super.key, required this.drawing});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84.6.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0).withOpacity(1),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: -3,
          )
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: drawing.imageUrl,
              placeholder: (context, url) => Center(
                  child: SizedBox(
                width: 84.6.w,
                height: 84.6.w,
                child: Center(
                  child: SizedBox(height: 5.h, width: 5.h, child: const CircularProgressIndicator(color: Colors.black)),
                ),
              )),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          SizedBox(
            height: 6.8.h,
            width: 80.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(drawing.gameWords[0],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    )),
                Text('#${drawing.gameWords[0]} #${drawing.gameWords[1]} #${drawing.gameWords[2]}',
                    style: const TextStyle(
                      fontSize: 16,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
