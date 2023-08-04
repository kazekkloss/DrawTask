import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';
import '../../../config/config.dart';

class SignInTab extends StatefulWidget {
  final VoidCallback onPressed;
  const SignInTab({
    required this.onPressed,
    super.key,
  });

  @override
  State<SignInTab> createState() => _SignInTabState();
}

class _SignInTabState extends State<SignInTab> {
  bool _showPassword = false;
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: SizedBox(
        height: 43.9.h,
        child: Form(
          key: _signInFormKey,
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'value is empty';
                    }
                    return null;
                  },
                  obscureText: !_showPassword,
                  controller: _passwordController,
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
                height: 5.2.h,
              ),
              MainButton(
                onPressed: () {
                  if (_signInFormKey.currentState!.validate()) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    context.read<AuthBloc>().add(SignInEvent(
                        context: context,
                        email: _emailController.text,
                        password: _passwordController.text));
                  }
                },
                text: 'LOG IN',
              ),
              SizedBox(
                height: 1.4.h,
              ),
              SizedBox(
                width: SizerUtil.deviceType == DeviceType.mobile
                    ? 84.w
                    : 5.6.h * 7,
                child: const Text(
                  'Forgot password or username?',
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5.6.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: widget.onPressed,
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(text: "Don't have an account? "),
                            TextSpan(
                                text: "Sign Up!",
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
