import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';
import '../../../config/config.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  WidgetsToImageController controller = WidgetsToImageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '#three',
              style: TextStyle(
                  fontSize: 24, fontFamily: 'IrishGrover', color: Colors.black),
            ),
            Text(
              '#random',
              style: TextStyle(
                  fontSize: 24, fontFamily: 'IrishGrover', color: Colors.black),
            ),
            Text(
              '#words',
              style: TextStyle(
                  fontSize: 24, fontFamily: 'IrishGrover', color: Colors.black),
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
          ClipRRect(
            child: RepaintBoundary(
              key: controller.containerKey,
              child: GestureDetector(
                onPanStart: (details) {
                  print(details);
                  context
                      .read<DrawBloc>()
                      .add(OnStartEvent(details: details, context: context));
                },
                onPanUpdate: (details) {
                  context
                      .read<DrawBloc>()
                      .add(OnUpdateEvent(details: details, context: context));
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.format_color_fill,
                        color: Colors.white,
                        size: 5.3.h,
                      )),
                  IconButton(
                      onPressed: () {},
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
                      onPressed: () {},
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
            onTap: () => {context.goNamed(RouteConstants.newGame), context.read<DrawBloc>().add(ClearEvent()) },
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
          InkWell(
            splashColor: const Color.fromRGBO(75, 75, 75, 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: () {},
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
          ),
        ],
      ),
    );
  }
}
