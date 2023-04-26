import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up-screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _showPassword = false;
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 25.h),
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      Text(
                        "DrawTask",
                        style: TextStyle(
                            fontSize: 4.2.h, fontFamily: 'IrishGrover'),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Get Creative!",
                        style: TextStyle(fontSize: 2.h),
                      ),
                      SizedBox(
                        height: 17.7.h,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 4.7.h,
                            width: 84.w,
                            child: TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                  hintText: 'email',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 14),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'email is empty';
                                }
                                if (!EmailValidator.validate(value)) {
                                  return 'email address is incorrect';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.2.h),
                      SizedBox(
                        height: 4.7.h,
                        width: 84.w,
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                              hintText: 'password',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                child: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 14),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'value is empty';
                            }
                            if (value.length <= 5) {
                              return 'passord id too short, min 6 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 1.2.h),
                      SizedBox(
                        height: 4.7.h,
                        width: 84.w,
                        child: TextFormField(
                          controller: _confirmPassword,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                              hintText: 'confirm password',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                child: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 14),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
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
                        height: 3.5.h,
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return GestureDetector(
                            child: Container(
                              height: 4.7.h,
                              width: 84.w,
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: const Center(
                                  child: Text(
                                'Create Account',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                            ),
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(SignUpEvent(
                                    context: context,
                                    email: _emailController.text,
                                    password: _passwordController.text));
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(bottom: 5.6.h),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context, true),
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(text: "Already have an account? "),
                                  TextSpan(
                                      text: "Sign In!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
