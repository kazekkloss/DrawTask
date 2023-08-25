import 'dart:typed_data';

import 'package:drawtask/cubits/cubits.dart';
import 'package:drawtask/screens/main/widgets/app_bar.dart';
import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';
import '../../../config/config.dart';
import '../../../models/models.dart';
import '../../../sockets/sockets.dart';
import 'widgets/widgets.dart';

enum _ActiveBarTool { none, backgroundColor, width, colors, shapes }

class DrawingScreen extends StatefulWidget {
  final Game game;
  const DrawingScreen({super.key, required this.game});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  WidgetsToImageController controller = WidgetsToImageController();
  _ActiveBarTool activeBarTool = _ActiveBarTool.none;
  Uint8List? bytes;
  bool loading = false;
  bool preparing = false;

  bool colorsTool = false;
  bool shapesTool = false;
  bool backgroundTool = false;
  bool widthTool = false;

  bool show = true;

  Color backgroundColor = const Color.fromRGBO(255, 255, 255, 1);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: TopAppBar(gameWords: widget.game.gameWords),
          body: Column(
            children: [
              Stack(children: [
                ClipRRect(
                  child: RepaintBoundary(
                    key: controller.containerKey,
                    child: GestureDetector(
                      onPanStart: (details) {
                        context.read<DrawBloc>().add(
                            OnStartEvent(details: details, context: context));
                        setState(() {
                          show = false;
                        });
                      },
                      onPanUpdate: (details) {
                        context.read<DrawBloc>().add(
                            OnUpdateEvent(details: details, context: context));
                      },
                      onPanEnd: (details) {
                        context.read<DrawBloc>().add(
                            OnEndEvent(details: details, context: context));
                        setState(() {
                          show = true;
                        });
                      },
                      child: BlocBuilder<DrawBloc, DrawState>(
                        builder: (context, state) {
                          return Container(
                            color: backgroundColor,
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
                AnimatedPositioned(
                  bottom: activeBarTool == _ActiveBarTool.backgroundColor
                      ? 0
                      : -20.9.h,
                  curve: Curves.linearToEaseOut,
                  duration: const Duration(milliseconds: 500),
                  left: 10.w,
                  child: ColorsTool(
                    onColorSelected: (color) {
                      setState(() {
                        backgroundColor = color;
                        activeBarTool = _ActiveBarTool.none;
                      });
                    },
                    splashColor: state.themeData.splashColor,
                  ),
                ),
                AnimatedPositioned(
                  bottom: activeBarTool == _ActiveBarTool.width ? 0 : -20.9.h,
                  curve: Curves.linearToEaseOut,
                  duration: const Duration(milliseconds: 500),
                  left: 31.w,
                  child: WidthTool(
                    splashColor: state.themeData.splashColor,
                    widthVoid: () => setState(() {
                      activeBarTool = _ActiveBarTool.none;
                    }),
                  ),
                ),
                AnimatedPositioned(
                  bottom: activeBarTool == _ActiveBarTool.colors ? 0 : -20.9.h,
                  curve: Curves.linearToEaseOut,
                  duration: const Duration(milliseconds: 500),
                  left: 43.w,
                  child: ColorsTool(
                    onColorSelected: (color) {
                      context
                          .read<DrawBloc>()
                          .add(ChangeColorEvent(color: color));
                      setState(
                        () {
                          activeBarTool = _ActiveBarTool.none;
                        },
                      );
                    },
                    splashColor: state.themeData.splashColor,
                  ),
                ),
                AnimatedPositioned(
                  bottom: activeBarTool == _ActiveBarTool.shapes ? 0 : -20.9.h,
                  curve: Curves.linearToEaseOut,
                  duration: const Duration(milliseconds: 500),
                  right: 9.7.w,
                  child: ShapesTool(
                    splashColor: state.themeData.splashColor,
                    shapesVoid: () => setState(() {
                      activeBarTool = _ActiveBarTool.none;
                    }),
                  ),
                ),
                AnimatedPositioned(
                  left: show ? 2.8.w : -4.4.h,
                  curve: Curves.linearToEaseOut,
                  duration: const Duration(milliseconds: 350),
                  top: 2.8.w,
                  child: TopButtons(primaryColor: state.themeData.primaryColor),
                ),
                AnimatedPositioned(
                  right: show ? 2.8.w : -10.7.h,
                  curve: Curves.linearToEaseOut,
                  duration: const Duration(milliseconds: 350),
                  top: 2.8.w,
                  child: DrawTimer(
                      game: widget.game,
                      primaryColor: state.themeData.primaryColor),
                ),
              ]),
              Tools(
                primaryColor: state.themeData.primaryColor,
                splashColor: state.themeData.splashColor,
                backgroundVoid: () {
                  activeBarTool == _ActiveBarTool.backgroundColor
                      ? setState(() {
                          activeBarTool = _ActiveBarTool.none;
                        })
                      : setState(() {
                          activeBarTool = _ActiveBarTool.backgroundColor;
                        });
                },
                widthVoid: () {
                  activeBarTool == _ActiveBarTool.width
                      ? setState(() {
                          activeBarTool = _ActiveBarTool.none;
                        })
                      : setState(() {
                          activeBarTool = _ActiveBarTool.width;
                        });
                },
                colorVoid: () {
                  activeBarTool == _ActiveBarTool.colors
                      ? setState(() {
                          activeBarTool = _ActiveBarTool.none;
                        })
                      : setState(() {
                          activeBarTool = _ActiveBarTool.colors;
                        });
                },
                shapeVoid: () {
                  activeBarTool == _ActiveBarTool.shapes
                      ? setState(() {
                          activeBarTool = _ActiveBarTool.none;
                        })
                      : setState(() {
                          activeBarTool = _ActiveBarTool.shapes;
                        });
                },
              ),
              SizedBox(height: 2.3.h),
              MainButton(
                primaryColor: const Color.fromARGB(255, 51, 51, 51),
                splashColor: const Color.fromARGB(255, 81, 81, 81),
                text: 'Back',
                textColor: const Color.fromARGB(255, 255, 255, 255),
                onPressed: () {
                  context.goNamed(RouteConstants.dashboard);
                  context.read<DrawBloc>().add(ClearEvent());
                },
              ),
              SizedBox(height: 1.2.h),
              !loading
                  ? MainButton(
                      text: !preparing ? 'Finish' : 'Preparing...',
                      onPressed: () {
                        setState(() {
                          preparing = true;
                        });
                        Future.microtask(() async {
                          final bytes = await controller.capture();
                          setState(() {
                            this.bytes = bytes!;
                            loading = true;
                            PictureSocket()
                                .addPicture(context, bytes, widget.game.id);
                          });
                        });
                      },
                    )
                  : SizedBox(
                      height: 4.7.h,
                      width: 4.7.h,
                      child:
                          const CircularProgressIndicator(color: Colors.black),
                    ),
            ],
          ),
        );
      },
    );
  }
}
