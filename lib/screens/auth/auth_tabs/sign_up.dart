import 'package:drawtask/blocs/auth/auth_bloc.dart';
import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

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
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final ValueNotifier<String?> _emailErrorMessage =
      ValueNotifier<String?>(null);
  final ValueNotifier<String?> _passwordErrorMessage =
      ValueNotifier<String?>(null);
  final ValueNotifier<String?> _confirmPasswordErrorMessage =
      ValueNotifier<String?>(null);
  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 43.9.h,
      child: Form(
        key: _signUpFormKey,
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
                  _obscureText.value ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            SizedBox(
              height: 2.3.h,
            ),
            CustomTextFormField(
              labelText: 'repeat password',
              validator: (value) {
                if (value!.isEmpty) {
                  _confirmPasswordErrorMessage.value = 'repeat password is empty';
                } else if (value != _passwordController.text) {
                  _confirmPasswordErrorMessage.value = 'password not match';
                } else {
                  _passwordErrorMessage.value = null;
                }
                return null;
              },
              controller: _confirmPasswordController,
              errorMessage: _confirmPasswordErrorMessage,
              obscureText: _obscureText,
            ),
            SizedBox(
              height: 5.2.h,
            ),
            MainButton(
              onPressed: () {
                if (_signUpFormKey.currentState!.validate()) {
                  if (_emailErrorMessage.value == null &&
                      _passwordErrorMessage.value == null &&
                      _confirmPasswordErrorMessage.value == null) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    context.read<AuthBloc>().add(SignUpEvent(
                        context: context,
                        email: _emailController.text,
                        password: _passwordController.text));
                  }
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
                    onTap: () {
                      widget.navigate();
                      _emailController.clear();
                      _passwordController.clear();
                      _confirmPasswordController.clear();
                    },
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
    );
  }
}
