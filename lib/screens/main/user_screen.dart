import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/models.dart';

class UserScreen extends StatelessWidget {
  final User user;
  const UserScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 3.h),
          child: Column(
            children: [
              Container(
                height: 11.h,
                width: 11.h,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 149, 149, 149),
                    borderRadius: BorderRadius.circular(15)),
              ),
              SizedBox(height: 2.h),
              Text(
                user.username.toString(),
                style: const TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
