import 'package:cached_network_image/cached_network_image.dart';
import 'package:drawtask/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../models/game.dart';
import '../../models/picture.dart';

class ScoreScreen extends StatelessWidget {
  final Game game;
  const ScoreScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    List<Picture> sortedPictures = List.from(game.pictures);
    sortedPictures.sort((a, b) => b.points.compareTo(a.points));
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            Container(
              height: 11.h,
              width: 11.h,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 149, 149, 149),
                  borderRadius: BorderRadius.circular(15)),
            ),
            SizedBox(
              height: 1.4.h,
            ),
            Text(
              'Winner is ${sortedPictures.first.userOwner.username!}!',
              style: const TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 3.2.h,
            ),
            Container(
              width: 85.w,
              height: 60.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 0),
                        spreadRadius: -2,
                        blurRadius: 6,
                        color: Colors.black),
                  ]),
              child: ListView.builder(
                shrinkWrap: false,
                itemCount: sortedPictures.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 5.12.w, right: 5.12.w, top: 1.2.h),
                    child: Container(
                      height: 15.h,
                      decoration: BoxDecoration(
                          color: sortedPictures[index].userOwner.id ==
                                  authBloc.state.user.id
                              ? const Color(0xffd2b8f5)
                              : const Color.fromRGBO(75, 75, 75, 1.0),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          sortedPictures[index].userOwner.id ==
                                  authBloc.state.user.id
                              ? Text(
                                  'You',
                                  style: TextStyle(
                                      fontSize: 2.h, color: Colors.white),
                                )
                              : Text(
                                  sortedPictures[index].userOwner.username!,
                                  style: TextStyle(
                                      fontSize: 2.h, color: Colors.white),
                                ),
                          ClipRRect(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 13.h,
                              color: Colors.amber,
                              child: CachedNetworkImage(
                                imageUrl: sortedPictures[index].imageUrl,
                                placeholder: (context, url) => Center(
                                  child: SizedBox(
                                    height: 5.h,
                                    width: 5.h,
                                    child: const CircularProgressIndicator(
                                        color: Colors.black),
                                  ),
                                ),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Text(
                            sortedPictures[index].points.toString(),
                            style:
                                TextStyle(fontSize: 4.7.h, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
