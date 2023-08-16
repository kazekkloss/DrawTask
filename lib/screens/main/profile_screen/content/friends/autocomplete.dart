import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../blocs/user/user_bloc.dart';
import '../../../../../models/models.dart';

class CustomAutocomplete extends StatelessWidget {
  final bool searchResults;
  final List<User> users;
  const CustomAutocomplete({super.key, required this.searchResults, required this.users});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
              height: searchResults ? users.length * 5.h : 0,
              width:
                  SizerUtil.deviceType == DeviceType.mobile ? 84.w : 5.6.h * 7,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 3),
                        spreadRadius: -4,
                        blurRadius: 4,
                        color: users.isNotEmpty && searchResults
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : const Color.fromARGB(0, 255, 255, 255))
                  ],
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(15))),
              curve: Curves.linearToEaseOut,
              duration: const Duration(milliseconds: 600),
              child: BlocBuilder<UsersBloc, UsersState>(
                builder: (context, state) {
                  return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 5.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.9.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  users[index].username!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add_circle_outline))
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            );
  }
}