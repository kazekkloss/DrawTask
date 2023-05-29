import 'package:drawtask/config/router/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../../blocs/blocs.dart';
import '../../../../../models/models.dart';
import '../../../../../repositories/repositories.dart';
import 'friends_list.dart';

class FriendsContent extends StatefulWidget {
  const FriendsContent({super.key});

  @override
  State<FriendsContent> createState() => _FriendsContentState();
}

class _FriendsContentState extends State<FriendsContent> {
  final TextEditingController _searchUsersController = TextEditingController();
  bool searchResults = false;
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    User currentUser = authBloc.state.user;
    return Stack(
      children: [
        const FriendsList(),
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
                  child: BlocBuilder<UsersBloc, UsersState>(
                    builder: (context, state) {
                      return ListView.builder(
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
                                  GestureDetector(
                                    onTap: () => users[index].id !=
                                            currentUser.id
                                        ? context.pushNamed(RouteConstants.user,
                                            extra: users[index])
                                        : null,
                                    child: Text(
                                      users[index].username!,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  if (users[index].id == currentUser.id)
                                    const Text('')
                                  else if (state.invitationsFromMe.any(
                                      (user) => user.id == users[index].id))
                                    const Text('')
                                  else if (state.friends.any(
                                      (user) => user.id == users[index].id))
                                    const Text('')
                                  else if (state.invitationsToMe.any(
                                      (user) => user.id == users[index].id))
                                    const Text('')
                                  else
                                    IconButton(
                                        onPressed: () {
                                          context.read<UsersBloc>().add(
                                              SendInvitationEvent(
                                                  context: context,
                                                  userId: users[index].id));
                                        },
                                        icon: const Icon(
                                            Icons.add_circle_outline))
                                ],
                              ),
                            ),
                          );
                        },
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
                    controller: _searchUsersController,
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
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _searchUsersController.clear();
                            setState(() {
                              searchResults = false;
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          )),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 14),
                      border: const OutlineInputBorder(
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
    );
  }
}
