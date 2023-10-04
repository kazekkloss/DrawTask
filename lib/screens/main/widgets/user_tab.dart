import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import 'widgets.dart';

class UserTab extends StatelessWidget {
  final Color color;
  final String username;
  final String assetName;
  final VoidCallback onTap;
  const UserTab(
      {super.key,
      required this.color,
      required this.username,
      required this.assetName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 5.4.w, right: 5.4.w, top: 1.18.h),
        child: SmallTab(
            color: color,
            child: Padding(
              padding: EdgeInsets.only(left: 4.1.w, right: 4.1.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: SizedBox(
                      height: 5.68.h,
                      child: SvgPicture.asset(
                        assetName,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
