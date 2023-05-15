import 'package:drawtask/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';

enum ContentType {
  accountSettings,
  drawings,
  firends,
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ContentType currentContentType = ContentType.drawings;
  bool searchResults = false;
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Column(
                children: [
                  Container(
                    height: 11.h,
                    width: 11.h,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 149, 149, 149),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    state.user.username.toString(),
                    style: const TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: 84.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          splashColor: const Color.fromRGBO(75, 75, 75, 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          onTap: () {
                            setState(() {
                              currentContentType = ContentType.accountSettings;
                            });
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                                color: currentContentType ==
                                        ContentType.accountSettings
                                    ? const Color.fromRGBO(75, 75, 75, 1.0)
                                    : const Color.fromRGBO(204, 204, 204, 1.0),
                                borderRadius: BorderRadius.circular(15)),
                            height: 4.7.h,
                            width: 26.9.w,
                            child: Center(
                                child: Text(
                              'Account Settings',
                              style: TextStyle(
                                fontSize: 12,
                                color: currentContentType ==
                                        ContentType.accountSettings
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            )),
                          ),
                        ),
                        InkWell(
                          splashColor: const Color.fromRGBO(75, 75, 75, 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          onTap: () {
                            setState(() {
                              currentContentType = ContentType.drawings;
                            });
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                                color: currentContentType ==
                                        ContentType.drawings
                                    ? const Color.fromRGBO(75, 75, 75, 1.0)
                                    : const Color.fromRGBO(204, 204, 204, 1.0),
                                borderRadius: BorderRadius.circular(15)),
                            height: 4.7.h,
                            width: 26.9.w,
                            child: Center(
                                child: Text(
                              'Drawings',
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    currentContentType == ContentType.drawings
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            )),
                          ),
                        ),
                        InkWell(
                          splashColor: const Color.fromRGBO(75, 75, 75, 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          onTap: () {
                            setState(() {
                              currentContentType = ContentType.firends;
                            });
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                                color: currentContentType == ContentType.firends
                                    ? const Color.fromRGBO(75, 75, 75, 1.0)
                                    : const Color.fromRGBO(204, 204, 204, 1.0),
                                borderRadius: BorderRadius.circular(15)),
                            height: 4.7.h,
                            width: 26.9.w,
                            child: Center(
                                child: Text(
                              'Friends',
                              style: TextStyle(
                                fontSize: 12,
                                color: currentContentType == ContentType.firends
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.2.h,
                    width: 3.2.h,
                  ),
                  getContentWidget()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getContentWidget() {
    switch (currentContentType) {
      case ContentType.accountSettings:
        return const Expanded(
            child: Center(
          child: Text('Account Settings'),
        ));
      case ContentType.drawings:
        return const Expanded(
            child: Center(
          child: Text('Drawings'),
        ));
      case ContentType.firends:
        return Expanded(
            child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: 84.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    const Text('Your Friends'),
                    SizedBox(height: 0.8.h),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 0),
                                spreadRadius: -2,
                                blurRadius: 6,
                                color: Colors.black)
                          ]),
                      child: const Center(
                        child: Text('You are lonely'),
                      ),
                    )),
                    SizedBox(
                      height: 2.h,
                    )
                  ],
                ),
              ),
            ),
            if (searchResults)
              Padding(
                padding: EdgeInsets.only(top: 2.5.h),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: users.length * 5.h + 5.h,
                    width: 84.w,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 0),
                              spreadRadius: -2,
                              blurRadius: 6,
                              color: Colors.black)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 5.h,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    users[index].username!,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon:
                                          const Icon(Icons.add_circle_outline))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 84.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Search Friends',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 0.6.h),
                    SizedBox(
                      height: 4.7.h,
                      child: TextFormField(
                        onChanged: (value) async {
                          if (value.isNotEmpty) {
                            users = await UserRepository().searchUsers(
                              context: context,
                              searchQuery: value,
                            );
                            setState(() {
                              users = users;
                              searchResults = true;
                            });
                          } else {
                            setState(() {
                              searchResults = false;
                            });
                          }
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
    }
  }
}
