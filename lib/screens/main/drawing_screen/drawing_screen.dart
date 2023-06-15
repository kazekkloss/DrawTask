import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';
import '../../../config/config.dart';
import '../../../models/models.dart';
import '../../../sockets/sockets.dart';

class DrawingScreen extends StatefulWidget {
  final Game game;
  const DrawingScreen({super.key, required this.game});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;
  bool loading = false;

  bool colorsPalette = false;
  bool shapesPalette = false;
  bool widthPalette = false;


  void _renderPicture() {
    setState(() {
      loading = true;
    });

    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 1));
      final bytes = await controller.capture();
      setState(() {
        this.bytes = bytes!;
        PictureSocket().addPicture(context, bytes, widget.game.id);
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '#${widget.game.gameWords[0]}',
              style: const TextStyle(
                  fontSize: 18, fontFamily: 'IrishGrover', color: Colors.black),
            ),
            Text(
              '#${widget.game.gameWords[1]}',
              style: const TextStyle(
                  fontSize: 18, fontFamily: 'IrishGrover', color: Colors.black),
            ),
            Text(
              '#${widget.game.gameWords[2]}',
              style: const TextStyle(
                  fontSize: 18, fontFamily: 'IrishGrover', color: Colors.black),
            )
          ],
        ),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                child: RepaintBoundary(
                  key: controller.containerKey,
                  child: GestureDetector(
                    onPanStart: (details) {
                      context.read<DrawBloc>().add(
                          OnStartEvent(details: details, context: context));
                    },
                    onPanUpdate: (details) {
                      context.read<DrawBloc>().add(
                          OnUpdateEvent(details: details, context: context));
                    },
                    onPanEnd: (details) {
                      context
                          .read<DrawBloc>()
                          .add(OnEndEvent(details: details, context: context));
                    },
                    child: BlocBuilder<DrawBloc, DrawState>(
                      builder: (context, state) {
                        return Container(
                          color: Colors.white,
                          child: SizedBox(
                            height: 60.3.h,
                            width: 100.w,
                            child: Stack(
                              children: [
                                CustomPaint(
                                  painter: Sketcher(
                                    sketches: state.listSketch,
                                  ),
                                ),
                                CustomPaint(
                                  painter: Sketcher(
                                    sketches: [state.sketch],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              if (colorsPalette)
                Positioned(
                  bottom: 0,
                  left: 10.w,
                  child: Container(
                    height: 20.9.h,
                    width: 26.1.w,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color.fromRGBO(183, 160, 213, 1)),
                    child: Center(
                      child: SizedBox(
                        height: 17.7.h,
                        width: 18.7.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.read<DrawBloc>().add(
                                        ChangeColorEvent(
                                            color: const Color.fromRGBO(
                                                87, 220, 54, 1)));
                                    setState(() {
                                      colorsPalette = false;
                                    });
                                  },
                                  child: Container(
                                    height: 8.4.w,
                                    width: 8.4.w,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color.fromRGBO(87, 220, 54, 1)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.read<DrawBloc>().add(
                                        ChangeColorEvent(
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1)));
                                    setState(() {
                                      colorsPalette = false;
                                    });
                                  },
                                  child: Container(
                                    height: 8.4.w,
                                    width: 8.4.w,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color.fromRGBO(0, 0, 0, 1)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.read<DrawBloc>().add(
                                        ChangeColorEvent(
                                            color: const Color.fromRGBO(
                                                40, 46, 193, 1)));
                                    setState(() {
                                      colorsPalette = false;
                                    });
                                  },
                                  child: Container(
                                    height: 8.4.w,
                                    width: 8.4.w,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color.fromRGBO(40, 46, 193, 1)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.read<DrawBloc>().add(
                                        ChangeColorEvent(
                                            color: const Color.fromRGBO(
                                                232, 201, 39, 1)));
                                    setState(() {
                                      colorsPalette = false;
                                    });
                                  },
                                  child: Container(
                                    height: 8.4.w,
                                    width: 8.4.w,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color.fromRGBO(232, 201, 39, 1)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.read<DrawBloc>().add(
                                        ChangeColorEvent(
                                            color: const Color.fromRGBO(
                                                205, 41, 41, 1)));
                                    setState(() {
                                      colorsPalette = false;
                                    });
                                  },
                                  child: Container(
                                    height: 8.4.w,
                                    width: 8.4.w,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color.fromRGBO(205, 41, 41, 1)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.read<DrawBloc>().add(
                                        ChangeColorEvent(
                                            color: const Color.fromRGBO(
                                                187, 45, 190, 1)));
                                    setState(() {
                                      colorsPalette = false;
                                    });
                                  },
                                  child: Container(
                                    height: 8.4.w,
                                    width: 8.4.w,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color.fromRGBO(187, 45, 190, 1)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.read<DrawBloc>().add(
                                        ChangeColorEvent(
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 1)));
                                    setState(() {
                                      colorsPalette = false;
                                    });
                                  },
                                  child: Container(
                                    height: 8.4.w,
                                    width: 8.4.w,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color:
                                            Color.fromRGBO(255, 255, 255, 1)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.read<DrawBloc>().add(
                                        ChangeColorEvent(
                                            color: const Color.fromRGBO(
                                                204, 204, 204, 1)));
                                    setState(() {
                                      colorsPalette = false;
                                    });
                                  },
                                  child: Container(
                                    height: 8.4.w,
                                    width: 8.4.w,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color:
                                            Color.fromRGBO(204, 204, 204, 1)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (widthPalette)
                Positioned(
                  bottom: 0,
                  left: 31.w,
                  child: Container(
                    height: 20.9.h,
                    width: 26.1.w,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color.fromRGBO(183, 160, 213, 1)),
                    child: Center(
                      child: SizedBox(
                        height: 17.7.h,
                        width: 18.7.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<DrawBloc>()
                                    .add(SkechWidthEvent(width: 40));
                                setState(() {
                                  widthPalette = false;
                                });
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: 2.2.h,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(51, 51, 51, 1),
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<DrawBloc>()
                                    .add(SkechWidthEvent(width: 34));
                                setState(() {
                                  widthPalette = false;
                                });
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: 1.5.h,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(51, 51, 51, 1),
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<DrawBloc>()
                                    .add(SkechWidthEvent(width: 24));
                                setState(() {
                                  widthPalette = false;
                                });
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: 1.h,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(51, 51, 51, 1),
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<DrawBloc>()
                                    .add(SkechWidthEvent(width: 18));
                                setState(() {
                                  widthPalette = false;
                                });
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: 0.8.h,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(51, 51, 51, 1),
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<DrawBloc>()
                                    .add(SkechWidthEvent(width: 10));
                                setState(() {
                                  widthPalette = false;
                                });
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: 0.5.h,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(51, 51, 51, 1),
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<DrawBloc>()
                                    .add(SkechWidthEvent(width: 5));
                                setState(() {
                                  widthPalette = false;
                                });
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: 0.3.h,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(51, 51, 51, 1),
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (shapesPalette)
                Positioned(
                  bottom: 0,
                  right: 9.7.w,
                  child: Container(
                    height: 20.9.h,
                    width: 26.1.w,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color.fromRGBO(183, 160, 213, 1)),
                    child: Center(
                      child: SizedBox(
                        height: 17.7.h,
                        width: 18.7.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.read<DrawBloc>().add(
                                        ChangeModeEvent(
                                            mode: DrawingMode.square));
                                    context
                                        .read<DrawBloc>()
                                        .add(SetFillEvent(filled: true));
                                    setState(() {
                                      shapesPalette = false;
                                    });
                                  },
                                  child: Container(
                                      height: 8.4.w,
                                      width: 8.4.w,
                                      color:
                                          const Color.fromRGBO(51, 51, 51, 1)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.read<DrawBloc>().add(
                                        ChangeModeEvent(
                                            mode: DrawingMode.square));
                                    context
                                        .read<DrawBloc>()
                                        .add(SetFillEvent(filled: false));
                                    setState(() {
                                      shapesPalette = false;
                                    });
                                  },
                                  child: Container(
                                      height: 8.4.w,
                                      width: 8.4.w,
                                      decoration:
                                          BoxDecoration(border: Border.all())),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.read<DrawBloc>().add(
                                        ChangeModeEvent(
                                            mode: DrawingMode.circle));
                                    context
                                        .read<DrawBloc>()
                                        .add(SetFillEvent(filled: true));
                                    setState(() {
                                      shapesPalette = false;
                                    });
                                  },
                                  child: Container(
                                    height: 8.4.w,
                                    width: 8.4.w,
                                    decoration: BoxDecoration(
                                        color:
                                            const Color.fromRGBO(51, 51, 51, 1),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all()),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.read<DrawBloc>().add(
                                        ChangeModeEvent(
                                            mode: DrawingMode.circle));
                                    context
                                        .read<DrawBloc>()
                                        .add(SetFillEvent(filled: false));
                                    setState(() {
                                      shapesPalette = false;
                                    });
                                  },
                                  child: Container(
                                      height: 8.4.w,
                                      width: 8.4.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all())),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<DrawBloc>().add(
                                    ChangeModeEvent(mode: DrawingMode.line));
                                setState(() {
                                  shapesPalette = false;
                                });
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: 3,
                                color: const Color.fromRGBO(51, 51, 51, 1),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      context.read<DrawBloc>().add(
                                          ChangeModeEvent(
                                              mode: DrawingMode.pencil));
                                      context
                                          .read<DrawBloc>()
                                          .add(SetFillEvent(filled: false));
                                      setState(() {
                                        shapesPalette = false;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.mode_edit_outline,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: 2.8.w,
                top: 2.8.w,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => context.read<DrawBloc>().add(UndoEvent()),
                      child: Container(
                        height: 9.4.w,
                        width: 9.4.w,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(210, 184, 245, 1),
                                width: 2.5),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.replay,
                          color: Color.fromRGBO(210, 184, 245, 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    GestureDetector(
                      onTap: () => context.read<DrawBloc>().add(ClearEvent()),
                      child: Container(
                        height: 9.4.w,
                        width: 9.4.w,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(210, 184, 245, 1),
                                width: 2.5),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.layers_clear,
                          color: Color.fromRGBO(210, 184, 245, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 8.3.h,
            width: 100.w,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(210, 184, 245, 1),
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: EdgeInsets.only(top: 0.4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widthPalette = false;
                          shapesPalette = false;
                          colorsPalette = !colorsPalette;
                        });
                      },
                      icon: Icon(
                        Icons.format_color_fill,
                        color: Colors.white,
                        size: 5.3.h,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          colorsPalette = false;
                          shapesPalette = false;
                          widthPalette = !widthPalette;
                        });
                      },
                      icon: Icon(
                        Icons.draw,
                        color: Colors.white,
                        size: 5.3.h,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.palette,
                        color: Colors.white,
                        size: 5.3.h,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widthPalette = false;
                          colorsPalette = false;
                          shapesPalette = !shapesPalette;
                        });
                      },
                      icon: Icon(
                        Icons.bubble_chart,
                        color: Colors.white,
                        size: 5.3.h,
                      ))
                ],
              ),
            ),
          ),
          SizedBox(height: 2.3.h),
          InkWell(
            splashColor: const Color.fromRGBO(217, 217, 217, 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: () => {
              context.goNamed(RouteConstants.newGame),
              context.read<DrawBloc>().add(ClearEvent())
            },
            child: Ink(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(217, 217, 217, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 4.7.h,
              width: 84.w,
              child: const Center(
                  child: Text(
                'Back',
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
            ),
          ),
          SizedBox(height: 1.2.h),
          !loading
              ? InkWell(
                  splashColor: const Color.fromRGBO(75, 75, 75, 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  onTap: () => _renderPicture(),
                  child: Ink(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(75, 75, 75, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 4.7.h,
                    width: 84.w,
                    child: const Center(
                        child: Text(
                      'Finish',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                  ),
                )
              : SizedBox(
                  height: 4.7.h,
                  width: 4.7.h,
                  child: const CircularProgressIndicator(color: Colors.black),
                ),
        ],
      ),
    );
  }
}
