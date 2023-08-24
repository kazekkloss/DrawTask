import 'package:drawtask/screens/main/profile_screen/content/friends/autocomplete.dart';
import 'package:drawtask/screens/main/profile_screen/content/friends/friends_list.dart';
import 'package:drawtask/screens/main/widgets/widgets.dart';
import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../blocs/blocs.dart';
import '../../../../../models/user.dart';
import '../../../../../repositories/repositories.dart';

class FriendsContent extends StatefulWidget {
  final void Function(int searchItem) onSearchResultsChanged;
  const FriendsContent({super.key, required this.onSearchResultsChanged});

  @override
  State<FriendsContent> createState() => _FriendsContentState();
}

class _FriendsContentState extends State<FriendsContent> {
  FriendsType friendsType = FriendsType.accepted;

  final TextEditingController _searchUsersController = TextEditingController();
  bool searchResults = false;
  List<User> users = [];

  final ValueNotifier<String?> _searchUsersMessage =
      ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(
            width: SizerUtil.deviceType == DeviceType.mobile ? 84.w : 5.6.h * 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Search Friends',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 0.8.h),
                CustomTextFormField(
                    suffixIcon: _searchUsersController.value.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _searchUsersController.clear();
                              setState(() {
                                users.clear();
                              });
                            },
                          )
                        : null,
                    onChanged: (value) async {
                      if (value.isNotEmpty) {
                        users = await FriendsRepository().searchUsers(
                          context: context,
                          searchQuery: value,
                        );
                        setState(() {
                          users = users;
                          widget.onSearchResultsChanged(users.length);
                          searchResults = true;
                        });
                      } else {
                        setState(() {
                          searchResults = false;
                          widget.onSearchResultsChanged(users.length);
                        });
                      }
                    },
                    controller: _searchUsersController,
                    errorMessage: _searchUsersMessage),
                SizedBox(height: 3.2.h),
                const Text(
                  'Your Friends',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 2.1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextButton(
                        text: 'ACCEPTED',
                        fontSize: 13,
                        onTap: () {
                          setState(() {
                            friendsType = FriendsType.accepted;
                          });
                        },
                        onTapped: friendsType == FriendsType.accepted),
                    CustomTextButton(
                        text: 'WAITING',
                        fontSize: 13,
                        onTap: () {
                          setState(() {
                            friendsType = FriendsType.waiting;
                          });
                        },
                        onTapped: friendsType == FriendsType.waiting),
                    CustomTextButton(
                        text: 'INVITATIONS',
                        fontSize: 13,
                        onTap: () {
                          setState(() {
                            friendsType = FriendsType.invitations;
                          });
                        },
                        onTapped: friendsType == FriendsType.invitations)
                  ],
                ),
                SizedBox(height: 3.h),
                BlocBuilder<FriendsBloc, FriendsState>(
                  builder: (context, state) {
                    switch (friendsType) {
                      case FriendsType.accepted:
                        return FriendsList(
                            friendsType: friendsType,
                            userlist: state.friends,
                            status: state.status);
                      case FriendsType.waiting:
                        return FriendsList(
                            friendsType: friendsType,
                            userlist: state.invitationsFromMe,
                            status: state.status);
                      case FriendsType.invitations:
                        return FriendsList(
                            friendsType: friendsType,
                            userlist: state.invitationsToMe,
                            status: state.status);
                    }
                  },
                )
              ],
            ),
          ),
          Positioned(
              top: 8.9.h,
              child: CustomAutocomplete(
                  searchResults: searchResults, users: users)),
        ],
      ),
    );
  }
}
