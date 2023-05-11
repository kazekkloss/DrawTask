import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';

class SetUsernameScreen extends StatefulWidget {
  const SetUsernameScreen({super.key});

  @override
  State<SetUsernameScreen> createState() => _SetUsernameScreenState();
}

class _SetUsernameScreenState extends State<SetUsernameScreen> {
  final _usernameFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();

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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 14.45.h),
                child: Form(
                  key: _usernameFormKey,
                  child: Column(
                    children: [
                      Container(
                        height: 33.17.h,
                        width: 84.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                              blurRadius: 10,
                              color: Color.fromRGBO(154, 154, 154, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.25.h, horizontal: 3.58.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Enter Username"),
                              SizedBox(height: 1.42.h),
                              TextFormField(
                                controller: _usernameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'username is empty';
                                  }
                                  if (value.length <= 3) {
                                    return 'username is too short, min 4 characters';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 14),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                              ),
                              SizedBox(height: 1.89.h),
                              const Text("Choose Avatar"),
                              SizedBox(height: 0.94.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 6.87.h,
                                    width: 6.87.h,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            217, 217, 217, 1),
                                        borderRadius:
                                            BorderRadius.circular(2.96.h)),
                                  ),
                                  Container(
                                    height: 6.87.h,
                                    width: 6.87.h,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            217, 217, 217, 1),
                                        borderRadius:
                                            BorderRadius.circular(2.96.h)),
                                  ),
                                  Container(
                                    height: 6.87.h,
                                    width: 6.87.h,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            217, 217, 217, 1),
                                        borderRadius:
                                            BorderRadius.circular(2.96.h)),
                                  ),
                                  Container(
                                    height: 6.87.h,
                                    width: 6.87.h,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            217, 217, 217, 1),
                                        borderRadius:
                                            BorderRadius.circular(2.96.h)),
                                  ),
                                  Container(
                                    height: 6.87.h,
                                    width: 6.87.h,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            217, 217, 217, 1),
                                        borderRadius:
                                            BorderRadius.circular(2.96.h)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.94.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 6.87.h,
                                    width: 6.87.h,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            217, 217, 217, 1),
                                        borderRadius:
                                            BorderRadius.circular(2.96.h)),
                                  ),
                                  Container(
                                    height: 6.87.h,
                                    width: 6.87.h,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            217, 217, 217, 1),
                                        borderRadius:
                                            BorderRadius.circular(2.96.h)),
                                  ),
                                  Container(
                                    height: 6.87.h,
                                    width: 6.87.h,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            217, 217, 217, 1),
                                        borderRadius:
                                            BorderRadius.circular(2.96.h)),
                                  ),
                                  Container(
                                    height: 6.87.h,
                                    width: 6.87.h,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            217, 217, 217, 1),
                                        borderRadius:
                                            BorderRadius.circular(2.96.h)),
                                  ),
                                  Container(
                                    height: 6.87.h,
                                    width: 6.87.h,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            217, 217, 217, 1),
                                        borderRadius:
                                            BorderRadius.circular(2.96.h)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 3.17.h),
                      InkWell(
                        splashColor: const Color.fromRGBO(75, 75, 75, 1.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        onTap: () {
                          if (_usernameFormKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(SaveUsernameEvent(
                                context: context,
                                username: _usernameController.text));
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
                              'Next',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
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
