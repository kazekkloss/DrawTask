import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

InputDecoration textFormFieldDecoration(
    {required String hintText, Widget? suffixIcon}) {
  return InputDecoration(
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 2.h, fontWeight: FontWeight.normal),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
      border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10))));
}
