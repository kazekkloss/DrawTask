import 'package:drawtask/cubits/cubits.dart';
import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:drawtask/sockets/sockets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';
import '../../../config/config.dart';
import '../../../models/models.dart';
import '../widgets/widgets.dart';

class FriendsGameScreen extends StatefulWidget {
  const FriendsGameScreen({super.key});

  @override
  State<FriendsGameScreen> createState() => _FriendsGameScreenState();
}

class _FriendsGameScreenState extends State<FriendsGameScreen> {
  final List<String> selectedUsers = [];

  @override
  void initState() {
    context.read<FriendsBloc>().add(GetFriendsEvent(friendsType: FriendsType.accepted, context: context, listLength: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final currentUserId = state.user.id;
        return Scaffold(
          appBar: const TopAppBar(
            gameWords: ["Friend's Game"],
          ),
          body: SizedBox(
            height: 100.h,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: SizedBox(
                          width: 85.w,
                          child: Column(children: [
                            Avatar(user: state.user),
                            SizedBox(height: 2.13.h),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Choose your 4 friends",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            SizedBox(height: 1.82.h),
                            BlocBuilder<FriendsBloc, FriendsState>(
                              builder: (context, state) {
                                List<User> friendsList = state.friends;
                                return ShadowContainer(
                                    height: friendsList.isEmpty ? 14.2.h : 10.48.h * friendsList.length.toDouble() + 3.48.h,
                                    child: state.status == FriendsStatus.loading
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                            ),
                                          )
                                        : friendsList.isEmpty
                                            ? const Center(child: Text("You don't have any friend invitations"))
                                            : Padding(
                                                padding: EdgeInsets.only(top: 1.18.h),
                                                child: ListView.builder(
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemCount: friendsList.length,
                                                    itemBuilder: (state, index) {
                                                      return BlocBuilder<ThemeCubit, ThemeState>(
                                                        builder: (context, state) {
                                                          return UserTab(
                                                              onTap: () {
                                                                if (!selectedUsers.contains(friendsList[index].id) && selectedUsers.length < 4) {
                                                                  selectedUsers.add(friendsList[index].id);
                                                                } else {
                                                                  selectedUsers.remove(friendsList[index].id);
                                                                }
                                                                setState(() {});
                                                              },
                                                              color: !selectedUsers.contains(friendsList[index].id)
                                                                  ? const Color.fromARGB(255, 75, 75, 75)
                                                                  : state.themeData.primaryColor,
                                                              username: friendsList[index].username!,
                                                              assetName: !selectedUsers.contains(friendsList[index].id)
                                                                  ? 'assets/svg/plus.svg'
                                                                  : 'assets/svg/minus.svg');
                                                        },
                                                      );
                                                    }),
                                              ));
                              },
                            ),
                            SizedBox(
                              height: 18.h,
                            )
                          ])),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  bottom: selectedUsers.length == 4 ? 0 : -7.h,
                  curve: Curves.linearToEaseOut,
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                      height: 15.h,
                      child: BottomPanel(
                          voidBack: () {
                            context.goNamed(RouteConstants.newGame);
                          },
                          finishButton: MainButton(
                            text: 'Finish',
                            onPressed: () {
                              selectedUsers.add(currentUserId);
                              GameSocket().createFriendsGame(context: context, selectedUsers: selectedUsers);
                            },
                          ))),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
