import 'package:drawtask/config/config.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _showPassword = false;
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  key: _signInFormKey,
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
                      SizedBox(
                        height: 4.7.h,
                        width: 84.w,
                        child: TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email is empty';
                            }
                            if (!EmailValidator.validate(value)) {
                              return 'email address is incorrect';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'email',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 14),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                      SizedBox(height: 1.2.h),
                      SizedBox(
                        height: 4.7.h,
                        width: 84.w,
                        child: TextFormField(
                          obscureText: !_showPassword,
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'value is empty';
                            }
                            return null;
                          },
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
                        ),
                      ),
                      SizedBox(
                        height: 3.5.h,
                      ),
                      InkWell(
                        splashColor: const Color.fromRGBO(75, 75, 75, 1.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        onTap: () {
                          if (_signInFormKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(SignInEvent(
                                context: context,
                                email: _emailController.text,
                                password: _passwordController.text));
                          }
                        },
                        child: Ink(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(75, 75, 75, 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: 4.7.h,
                          width: 84.w,
                          child: const Center(
                              child: Text(
                            'Log In',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                        ),
                      ),
                      SizedBox(height: 1.7.h),
                      SizedBox(
                        width: 84.w,
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
                            onTap: () =>
                                context.pushNamed(RouteConstants.signUp),
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(text: "Don't have an account? "),
                                  TextSpan(
                                      text: "Sign Up!",
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
