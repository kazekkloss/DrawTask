import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../blocs/blocs.dart';
import '../../../../models/models.dart';
import '../../../../repositories/repositories.dart';

enum FriendsType {
  accepted,
  waiting,
  invitations,
}

class FriendsWidget extends StatefulWidget {
  const FriendsWidget({super.key});

  @override
  State<FriendsWidget> createState() => _FriendsWidgetState();
}

class _FriendsWidgetState extends State<FriendsWidget> {
  FriendsType currentFriendsType = FriendsType.accepted;
  bool searchResults = false;
  List<User> users = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Stack(
          children: [
            Center(
              child: SizedBox(
                width: 84.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.8.h),
                    const Text(
                      'Your Friends',
                      style: TextStyle(fontSize: 21),
                    ),
                    SizedBox(height: 1.4.h),
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
                                currentFriendsType = FriendsType.accepted;
                              });
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                  color: currentFriendsType ==
                                          FriendsType.accepted
                                      ? const Color.fromRGBO(75, 75, 75, 1.0)
                                      : const Color.fromRGBO(
                                          204, 204, 204, 1.0),
                                  borderRadius: BorderRadius.circular(15)),
                              height: 4.7.h,
                              width: 26.9.w,
                              child: Center(
                                  child: Text(
                                'Accepted',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      currentFriendsType == FriendsType.accepted
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
                                currentFriendsType = FriendsType.waiting;
                              });
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                  color: currentFriendsType ==
                                          FriendsType.waiting
                                      ? const Color.fromRGBO(75, 75, 75, 1.0)
                                      : const Color.fromRGBO(
                                          204, 204, 204, 1.0),
                                  borderRadius: BorderRadius.circular(15)),
                              height: 4.7.h,
                              width: 26.9.w,
                              child: Center(
                                  child: Text(
                                'Waiting',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      currentFriendsType == FriendsType.waiting
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
                                currentFriendsType = FriendsType.invitations;
                              });
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                  color: currentFriendsType ==
                                          FriendsType.invitations
                                      ? const Color.fromRGBO(75, 75, 75, 1.0)
                                      : const Color.fromRGBO(
                                          204, 204, 204, 1.0),
                                  borderRadius: BorderRadius.circular(15)),
                              height: 4.7.h,
                              width: 26.9.w,
                              child: Center(
                                  child: Text(
                                'Invitations',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: currentFriendsType ==
                                          FriendsType.invitations
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
                    ),
                    Container(
                        height: 28.h,
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
                        child: state.status == UsersStatus.loading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.black,
                              ))
                            : currentFriendsType == FriendsType.accepted
                                ? state.friends.isEmpty
                                    ? const Center(
                                        child:
                                            Text('You dont have any friends'),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: state.friends.length,
                                        itemBuilder: (context, index) {
                                          return Text(
                                              state.friends[index].username!);
                                        },
                                      )
                                : currentFriendsType == FriendsType.waiting
                                    ? state.invitationsFromMe.isEmpty
                                        ? const Center(
                                            child: Text(
                                                'You dont have any sended invitations'),
                                          )
                                        : Padding(
                                            padding:
                                                EdgeInsets.only(top: 2.3.h),
                                            child: ListView.builder(
                                              shrinkWrap: false,
                                              itemCount: state
                                                  .invitationsFromMe.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.12.w,
                                                      right: 5.12.w,
                                                      top: 1.2.h),
                                                  child: Container(
                                                    height: 9.36.h,
                                                    decoration: BoxDecoration(
                                                        color: const Color
                                                                .fromRGBO(
                                                            75, 75, 75, 1.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          state
                                                              .invitationsFromMe[
                                                                  index]
                                                              .username!,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 21),
                                                        ),
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              Icons
                                                                  .delete_outline,
                                                              color:
                                                                  Colors.white,
                                                              size: 5.h,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                    : currentFriendsType ==
                                            FriendsType.invitations
                                        ? state.invitationsToMe.isEmpty
                                            ? const Center(
                                                child: Text(
                                                    'You dont have any invitations'),
                                              )
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: state
                                                    .invitationsToMe.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    color: Colors.amber,
                                                    width: 74.3,
                                                    height: 9.3,
                                                    child: Text(state
                                                        .invitationsToMe[index]
                                                        .username!),
                                                  );
                                                },
                                              )
                                        : null),
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
                                      onPressed: () {
                                        context.read<UserBloc>().add(
                                            SendInvitationEvent(
                                                context: context,
                                                userId: users[index].id));
                                      },
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
        );
      },
    );
  }
}
