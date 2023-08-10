import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../cubits/cubits.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final ValueNotifier<String?> errorMessage;
  final ValueNotifier<bool?>? obscureText;
  final Widget? suffixIcon;
  const CustomTextFormField(
      {super.key,
      this.labelText,
      required this.validator,
      required this.controller,
      required this.errorMessage,
      this.obscureText,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    Color errorColor = const Color.fromRGBO(135, 4, 4, 1);
    return SizedBox(
      width: SizerUtil.deviceType == DeviceType.mobile ? 84.w : 5.6.h * 7,
      height: 5.6.h,
      child: ValueListenableBuilder<String?>(
        valueListenable: errorMessage,
        builder: (context, currentErrorMessage, child) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return ValueListenableBuilder<bool?>(
                  valueListenable: obscureText ?? ValueNotifier<bool?>(false),
                  builder: (context, currentObscureText, child) {
                    return TextFormField(
                      cursorColor: state.themeData.primaryColor,
                      obscureText: currentObscureText ?? false,
                      validator: validator,
                      controller: controller,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: errorMessage.value == null
                                      ? state.themeData.primaryColor
                                      : errorColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: errorMessage.value == null
                                      ? const Color.fromRGBO(51, 51, 51, 1)
                                      : errorColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          labelText: currentErrorMessage ?? labelText,
                          floatingLabelStyle: TextStyle(
                            color: errorMessage.value == null
                                ? state.themeData.primaryColor
                                : errorColor,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 2.h,
                            fontWeight: FontWeight.normal,
                            color: errorMessage.value == null
                                ? const Color.fromRGBO(51, 51, 51, 1)
                                : errorColor,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 14),
                          suffixIcon: suffixIcon,
                          suffixIconColor: errorMessage.value == null
                              ? const Color.fromRGBO(51, 51, 51, 1)
                              : errorColor),
                    );
                  });
            },
          );
        },
      ),
    );
  }
}
