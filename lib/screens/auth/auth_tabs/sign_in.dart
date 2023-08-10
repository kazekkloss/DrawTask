import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';

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
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ValueNotifier<String?> _emailErrorMessage =
      ValueNotifier<String?>(null);
  final ValueNotifier<String?> _passwordErrorMessage =
      ValueNotifier<String?>(null);
  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 43.9.h,
      child: Form(
        key: _signInFormKey,
        child: Column(
          children: [
            SizedBox(
              height: 2.5.h,
            ),
            CustomTextFormField(
              labelText: 'e-mail',
              errorMessage: _emailErrorMessage,
              validator: (value) {
                if (value!.isEmpty) {
                  _emailErrorMessage.value = 'email is empty';
                } else if (!EmailValidator.validate(value)) {
                  _emailErrorMessage.value = 'email address is incorrect';
                } else {
                  _emailErrorMessage.value = null;
                }
                return null;
              },
              controller: _emailController,
            ),
            SizedBox(
              height: 2.3.h,
            ),
            CustomTextFormField(
              labelText: 'password',
              validator: (value) {
                if (value!.isEmpty) {
                  _passwordErrorMessage.value = 'password is empty';
                } else {
                  _passwordErrorMessage.value = null;
                }
                return null;
              },
              controller: _passwordController,
              errorMessage: _passwordErrorMessage,
              obscureText: _obscureText,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText.value = !_obscureText.value;
                  });
                },
                child: Icon(
                  _obscureText.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
            ),
            SizedBox(
              height: 5.2.h,
            ),
            MainButton(
              onPressed: () {
                if (_signInFormKey.currentState!.validate()) {
                  if (_emailErrorMessage.value == null &&
                      _passwordErrorMessage.value == null) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    context.read<AuthBloc>().add(SignInEvent(
                        context: context,
                        email: _emailController.text,
                        password: _passwordController.text));
                  }
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
                    onTap: () {
                      widget.onPressed();

                      _emailController.clear();
                      _passwordController.clear();
                    },
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
    );
  }
}
