import 'package:drawtask/screens/main/score_screen/widgets/score_tab.dart';
import 'package:drawtask/screens/main/widgets/widgets.dart';
import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../models/game.dart';
import '../../../models/picture.dart';

class ScoreScreen extends StatefulWidget {
  final Game game;
  const ScoreScreen({super.key, required this.game});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  bool zoom = false;
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    List<Picture> sortedPictures = List.from(widget.game.pictures);
    sortedPictures.sort((a, b) => b.points.compareTo(a.points));
    return Scaffold(
      appBar: TopAppBar(gameWords: widget.game.gameWords, isLeading: true),
      body: SingleChildScrollView(
          child: SizedBox(
        height: 90.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            Avatar(
              user: sortedPictures.first.userOwner,
              isUsername: false,
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
            SizedBox(
              width: 85.w,
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Players",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.2.h),
            ShadowContainer(
              height: 10.48.h * widget.game.pictures.length.toDouble() + 3.48.h,
              child: Padding(
                padding: EdgeInsets.only(top: 1.18.h),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: false,
                  itemCount: sortedPictures.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          zoom = true;
                        });
                      },
                      child: ScoreTab(
                        onTap: () {
                          setState(() {
                            imageUrl = sortedPictures[index].imageUrl;
                          });
                        },
                        picture: sortedPictures[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )),
      //
      // Stack(
      //   children: [
      //     Column(
      //       children: [
      //         Center(
      //           child: SingleChildScrollView(
      //             child: Column(
      //               children: [
      //                 SizedBox(
      //                   height: 3.h,
      //                 ),
      //                 Avatar(
      //                   user: sortedPictures.first.userOwner,
      //                   isUsername: false,
      //                 ),
      //                 SizedBox(
      //                   height: 1.4.h,
      //                 ),
      //                 Text(
      //                   'Winner is ${sortedPictures.first.userOwner.username!}!',
      //                   style: const TextStyle(fontSize: 25),
      //                 ),
      //                 SizedBox(
      //                   height: 3.2.h,
      //                 ),
      //                 SizedBox(
      //                   width: 85.w,
      //                   child: const Align(
      //                     alignment: Alignment.centerLeft,
      //                     child: Text(
      //                       "Players",
      //                       style: TextStyle(
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.w300,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(height: 1.2.h),
      //                 ShadowContainer(
      //                   height:
      //                       10.48.h * widget.game.pictures.length.toDouble() +
      //                           3.48.h,
      //                   child: Padding(
      //                     padding: EdgeInsets.only(top: 1.18.h),
      //                     child: ListView.builder(
      //                       physics: const NeverScrollableScrollPhysics(),
      //                       shrinkWrap: false,
      //                       itemCount: sortedPictures.length,
      //                       itemBuilder: (context, index) {
      //                         return GestureDetector(
      //                           onTap: () {
      //                             setState(() {
      //                               zoom = true;
      //                             });
      //                           },
      //                           child: ScoreTab(
      //                             onTap: () {
      //                               setState(() {
      //                                 imageUrl = sortedPictures[index].imageUrl;
      //                               });
      //                             },
      //                             picture: sortedPictures[index],
      //                           ),
      //                         );
      //                       },
      //                     ),
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //         ),
      //         Column(
      //           mainAxisAlignment: MainAxisAlignment.end,
      //           children: [
      //             Padding(
      //               padding: EdgeInsets.only(bottom: 7.1.h),
      //               child: MainButton(
      //                 primaryColor: const Color.fromARGB(255, 51, 51, 51),
      //                 splashColor: const Color.fromARGB(255, 81, 81, 81),
      //                 textColor: const Color.fromARGB(255, 255, 255, 255),
      //                 text: 'Back',
      //                 onPressed: () {
      //                   context.goNamed(RouteConstants.dashboard);
      //                 },
      //               ),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //     if (imageUrl.isNotEmpty)
      //       ZoomDrawing(
      //           zoom: zoom,
      //           imageUrl: imageUrl,
      //           onTap: () {
      //             setState(() {
      //               imageUrl = '';
      //             });
      //           })
      //   ],
      // ),
    );
  }
}
