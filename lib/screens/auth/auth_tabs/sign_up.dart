import 'package:drawtask/blocs/auth/auth_bloc.dart';
import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config.dart';

class SignUpTab extends StatefulWidget {
  final VoidCallback navigate;
  const SignUpTab({
    required this.navigate,
    super.key,
  });

  @override
  State<SignUpTab> createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> {
  bool _showPassword = false;
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Form(
        key: _signUpFormKey,
        child: SizedBox(
          height: 43.9.h,
          child: Column(
            children: [
              SizedBox(
                width: SizerUtil.deviceType == DeviceType.mobile
                    ? 84.w
                    : 5.6.h * 7,
                height: 5.6.h,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'email is empty';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'email address is incorrect';
                    }
                    return null;
                  },
                  controller: _emailController,
                  decoration: textFormFieldDecoration(hintText: 'e-mail'),
                ),
              ),
              SizedBox(
                height: 2.3.h,
              ),
              SizedBox(
                width: SizerUtil.deviceType == DeviceType.mobile
                    ? 84.w
                    : 5.6.h * 7,
                height: 5.6.h,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'value is empty';
                    }
                    if (value.length <= 5) {
                      return 'passord id too short, min 6 characters';
                    }
                    return null;
                  },
                  decoration: textFormFieldDecoration(
                    hintText: 'password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.3.h,
              ),
              SizedBox(
                width: SizerUtil.deviceType == DeviceType.mobile
                    ? 84.w
                    : 5.6.h * 7,
                height: 5.6.h,
                child: TextFormField(
                  controller: _confirmPassword,
                  obscureText: !_showPassword,
                  decoration: textFormFieldDecoration(
                    hintText: 'confirm password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'value is empty';
                    }
                    if (value != _passwordController.text) {
                      return 'password not match';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 5.2.h,
              ),
              MainButton(
                onPressed: () {
                  if (_signUpFormKey.currentState!.validate()) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    context.read<AuthBloc>().add(SignUpEvent(
                        context: context,
                        email: _emailController.text,
                        password: _passwordController.text));
                  }
                },
                text: 'CREATE ACCOUNT',
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5.6.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: widget.navigate,
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(text: "Already have an account? "),
                            TextSpan(
                                text: "Sign In!",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
