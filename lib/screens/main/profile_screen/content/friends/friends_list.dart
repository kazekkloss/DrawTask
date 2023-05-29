import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../../blocs/blocs.dart';
import '../../../../../config/config.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  void initState() {
    context.read<UsersBloc>().add(GetUsersEvent(
        friendsType: FriendsType.accepted, context: context, listLength: 0));
    context.read<UsersBloc>().add(GetUsersEvent(
        friendsType: FriendsType.waiting, context: context, listLength: 0));
    context.read<UsersBloc>().add(GetUsersEvent(
        friendsType: FriendsType.invitations, context: context, listLength: 0));
    super.initState();
  }

  FriendsType currentFriendsType = FriendsType.accepted;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        return Center(
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
                            context.read<UsersBloc>().add(GetUsersEvent(
                                listLength: 0,
                                friendsType: FriendsType.accepted,
                                context: context));
                          });
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              color: currentFriendsType == FriendsType.accepted
                                  ? const Color.fromRGBO(75, 75, 75, 1.0)
                                  : const Color.fromRGBO(204, 204, 204, 1.0),
                              borderRadius: BorderRadius.circular(15)),
                          height: 4.7.h,
                          width: 26.9.w,
                          child: Center(
                              child: Text(
                            'Accepted',
                            style: TextStyle(
                              fontSize: 12,
                              color: currentFriendsType == FriendsType.accepted
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
                            context.read<UsersBloc>().add(GetUsersEvent(
                                listLength: 0,
                                friendsType: FriendsType.waiting,
                                context: context));
                          });
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              color: currentFriendsType == FriendsType.waiting
                                  ? const Color.fromRGBO(75, 75, 75, 1.0)
                                  : const Color.fromRGBO(204, 204, 204, 1.0),
                              borderRadius: BorderRadius.circular(15)),
                          height: 4.7.h,
                          width: 26.9.w,
                          child: Center(
                              child: Text(
                            'Waiting',
                            style: TextStyle(
                              fontSize: 12,
                              color: currentFriendsType == FriendsType.waiting
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
                            context.read<UsersBloc>().add(GetUsersEvent(
                                listLength: 0,
                                friendsType: FriendsType.invitations,
                                context: context));
                          });
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              color: currentFriendsType ==
                                      FriendsType.invitations
                                  ? const Color.fromRGBO(75, 75, 75, 1.0)
                                  : const Color.fromRGBO(204, 204, 204, 1.0),
                              borderRadius: BorderRadius.circular(15)),
                          height: 4.7.h,
                          width: 26.9.w,
                          child: Center(
                              child: Text(
                            'Invitations',
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  currentFriendsType == FriendsType.invitations
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
                  child: currentFriendsType == FriendsType.accepted
                      ? state.status == UsersStatus.loading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: false,
                              itemCount: state.friends.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.12.w,
                                          right: 5.12.w,
                                          top: 1.2.h),
                                      child: Container(
                                        height: 9.36.h,
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                75, 75, 75, 1.0),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: () => context.pushNamed(
                                                  RouteConstants.user,
                                                  extra: state.friends[index]),
                                              child: Text(
                                                state.friends[index].username!,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 21),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  context.read<UsersBloc>().add(
                                                      DeleteUserEvent(
                                                          friendsType:
                                                              currentFriendsType,
                                                          context: context,
                                                          userId: state
                                                              .friends[index]
                                                              .id));
                                                },
                                                icon: Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.white,
                                                  size: 5.h,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                      : currentFriendsType == FriendsType.waiting
                          ? state.status == UsersStatus.loading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: false,
                                  itemCount: state.invitationsFromMe.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.12.w,
                                              right: 5.12.w,
                                              top: 1.2.h),
                                          child: Container(
                                            height: 9.36.h,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    75, 75, 75, 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                GestureDetector(
                                                  onTap: () => context.pushNamed(
                                                  RouteConstants.user,
                                                  extra: state.invitationsFromMe[index]),
                                                  child: Text(
                                                    state.invitationsFromMe[index]
                                                        .username!,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 21),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      context
                                                          .read<UsersBloc>()
                                                          .add(DeleteUserEvent(
                                                              friendsType:
                                                                  currentFriendsType,
                                                              context: context,
                                                              userId: state
                                                                  .invitationsFromMe[
                                                                      index]
                                                                  .id));
                                                    },
                                                    icon: Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.white,
                                                      size: 5.h,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (index ==
                                            state.invitationsFromMe.length - 1)
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                        if (index ==
                                            state.invitationsFromMe.length - 1)
                                          IconButton(
                                              onPressed: () {
                                                context.read<UsersBloc>().add(
                                                    GetUsersEvent(
                                                        listLength: state
                                                            .invitationsFromMe
                                                            .length,
                                                        friendsType:
                                                            FriendsType.waiting,
                                                        context: context));
                                              },
                                              icon: const Icon(
                                                  Icons.expand_more)),
                                      ],
                                    );
                                  },
                                )
                          : currentFriendsType == FriendsType.invitations
                              ? state.status == UsersStatus.loading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: false,
                                      itemCount: state.invitationsToMe.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.12.w,
                                              right: 5.12.w,
                                              top: 1.2.h),
                                          child: Container(
                                            height: 9.36.h,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    75, 75, 75, 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                GestureDetector(
                                                  onTap: () => context.pushNamed(
                                                  RouteConstants.user,
                                                  extra: state.invitationsToMe[index]),
                                                  child: Text(
                                                    state.invitationsToMe[index]
                                                        .username!,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 21),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      context.read<UsersBloc>().add(
                                                          ConfirmInvitationEvent(
                                                              context: context,
                                                              userId: state
                                                                  .invitationsToMe[
                                                                      index]
                                                                  .id));
                                                    },
                                                    icon: Icon(
                                                      Icons.add_outlined,
                                                      color: Colors.white,
                                                      size: 5.h,
                                                    )),
                                                IconButton(
                                                    onPressed: () {
                                                      context
                                                          .read<UsersBloc>()
                                                          .add(DeleteUserEvent(
                                                              friendsType:
                                                                  currentFriendsType,
                                                              context: context,
                                                              userId: state
                                                                  .invitationsToMe[
                                                                      index]
                                                                  .id));
                                                    },
                                                    icon: Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.white,
                                                      size: 5.h,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                              : null,
                ),
                SizedBox(
                  height: 2.h,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
