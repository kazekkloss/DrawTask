import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/models.dart';

class GameScreen extends StatefulWidget {
  final Game game;
  const GameScreen({super.key, required this.game});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //List<>
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SizedBox(
        width: 84.6.w,
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('#${widget.game.gameWords[0]}',
                    style: const TextStyle(fontSize: 15)),
                Text('#${widget.game.gameWords[1]}',
                    style: const TextStyle(fontSize: 15)),
                Text('#${widget.game.gameWords[2]}',
                    style: const TextStyle(fontSize: 15)),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: false,
                itemCount: widget.game.pictures.length,
                itemBuilder: (context, index) {
                  return widget.game.pictures[index].imageUrl != ''
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 2.3.h),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 84.6.w,
                                child: Text(
                                  'Player ${index + 1}',
                                  style: TextStyle(fontSize: 1.9.h),
                                ),
                              ),
                              SizedBox(
                                height: 1.1.h,
                              ),
                              Container(
                                height: 46.6.h,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 0.75),
                                      spreadRadius: -2,
                                      blurRadius: 8,
                                      color: Color.fromRGBO(108, 108, 108, 1),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 84.6.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xffd9d9d9),
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(0, 0.75),
                                              spreadRadius: -2,
                                              blurRadius: 8,
                                              color: Color.fromRGBO(
                                                  108, 108, 108, 1),
                                            ),
                                          ]),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: CachedNetworkImage(
                                          imageUrl: widget
                                              .game.pictures[index].imageUrl,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.9.h,
                                    ),
                                    SizedBox(
                                      width: 84.6.w,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 2.5.w),
                                        child: Text(widget.game.pictures[index]
                                            .userOwner.username!),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 2.0.h),
                              SizedBox(
                                width: 67.9.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 5.3.h,
                                      width: 5.3.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xffd9d9d9)),
                                      child: Center(
                                        child: Text(
                                          "1",
                                          style: TextStyle(
                                            fontSize: 1.8.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 5.3.h,
                                      width: 5.3.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xffd9d9d9)),
                                      child: Center(
                                        child: Text(
                                          "2",
                                          style: TextStyle(
                                            fontSize: 1.8.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 5.3.h,
                                      width: 5.3.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xffd9d9d9)),
                                      child: Center(
                                        child: Text(
                                          "3",
                                          style: TextStyle(
                                            fontSize: 1.8.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 5.3.h,
                                      width: 5.3.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xffd9d9d9)),
                                      child: Center(
                                        child: Text(
                                          "4",
                                          style: TextStyle(
                                            fontSize: 1.8.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 5.3.h,
                                      width: 5.3.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xffd9d9d9)),
                                      child: Center(
                                        child: Text(
                                          "5",
                                          style: TextStyle(
                                            fontSize: 1.8.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      : null;
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
