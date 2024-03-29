import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../models/user.dart';

class Avatar extends StatelessWidget {
  final bool? isUsername;
  final User user;
  const Avatar({super.key, required this.user, bool? isUsername})
      : isUsername = isUsername ?? true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 11.h,
          width: 11.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: user.avatar == null
                ? null
                : Lottie.asset(user.avatar!, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 2.h),
        if (isUsername!)
          Column(
            children: [
              Text(
                user.username.toString(),
                style: const TextStyle(fontSize: 25),
              ),
              SizedBox(height: 2.h),
            ],
          ),
      ],
    );
  }
}
