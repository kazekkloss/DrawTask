import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SetUsernameScreen extends StatelessWidget {
  static const routeName = '/set_username_screen';
  const SetUsernameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        title: Text(
          "DrawTask",
          style: TextStyle(
              fontSize: 2.8.h, fontFamily: 'IrishGrover', color: Colors.black),
        ),
      ),
      body: const Center(
        child: Text('set username screen'),
      ),
    );
  }
}
