import 'package:drawtask/repositories/friends_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../blocs/blocs.dart';
import '../../../../../models/models.dart';
import '../../../../widgets/widgets.dart';

class FriendsList extends StatelessWidget {
  final FriendsType friendsType;
  final List<User> userlist;
  final FriendsStatus status;
  const FriendsList(
      {super.key,
      required this.friendsType,
      required this.userlist,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsBloc, FriendsState>(
      builder: (context, state) {
        return ShadowContainer(
          height: userlist.isEmpty
              ? 14.2.h
              : 10.48.h * userlist.length.toDouble() + 3.48.h,
          child: status == FriendsStatus.loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : userlist.isEmpty
                  ? const Center(
                      child: Text("You don't have any friend invitations"))
                  : Padding(
                      padding: EdgeInsets.only(top: 1.18.h),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: userlist.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 5.4.w, right: 5.4.w, top: 1.18.h),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 75, 75, 75),
                              ),
                              height: 9.3.h,
                              width: 74.w,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 4.1.w, right: 7.7.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      userlist[index].username!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 23.w,
                                      child: Row(
                                        mainAxisAlignment: friendsType ==
                                                FriendsType.invitations
                                            ? MainAxisAlignment.spaceBetween
                                            : MainAxisAlignment.end,
                                        children: [
                                          if (friendsType ==
                                              FriendsType.invitations)
                                            GestureDetector(
                                              onTap: () {
                                                FriendsRepository()
                                                    .confirmInvitation(
                                                        context: context,
                                                        userId:
                                                            userlist[index].id);
                                              },
                                              child: SizedBox(
                                                height: 3.8.h,
                                                width: 3.8.h,
                                                child: SvgPicture.asset(
                                                  'assets/svg/add_friend.svg',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          GestureDetector(
                                            onTap: () {
                                              FriendsRepository().deleteFriend(
                                                  context: context,
                                                  userId: userlist[index].id,
                                                  currentListLength:
                                                      userlist.length,
                                                  friendsType: friendsType);
                                            },
                                            child: SizedBox(
                                              height: 3.8.h,
                                              child: SvgPicture.asset(
                                                'assets/svg/trash.svg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        );
      },
    );
  }
}
