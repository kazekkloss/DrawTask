import 'package:cached_network_image/cached_network_image.dart';
import 'package:drawtask/blocs/drawings/drawings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class DrawingsWidget extends StatefulWidget {
  const DrawingsWidget({super.key});

  @override
  State<DrawingsWidget> createState() => _DrawingsWidgetState();
}

class _DrawingsWidgetState extends State<DrawingsWidget> {
  @override
  void initState() {
    context.read<DrawingsBloc>().add(GetMyDrawingsEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawingsBloc, DrawingsState>(
      builder: (context, state) {
        return SizedBox(
          width: 84.6.w,
          child: state.status == DrawingsStatus.loading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.black,
                ))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.myDrawings.length,
                  itemBuilder: (context, index) {
                    return state.myDrawings.isEmpty
                        ? const Center(
                            child: Text("You have not won drawings yet"))
                        : Container(
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
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xffd9d9d9),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(0, 0.75),
                                        spreadRadius: -2,
                                        blurRadius: 8,
                                        color: Color.fromRGBO(108, 108, 108, 1),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          state.myDrawings[index].imageUrl,
                                      placeholder: (context, url) => Center(
                                          child: SizedBox(
                                              height: 5.h,
                                              width: 5.h,
                                              child:
                                                  const CircularProgressIndicator(
                                                      color: Colors.black))),
                                      fit: BoxFit.contain,
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '#${state.myDrawings[index].gameWords[0]}  #${state.myDrawings[index].gameWords[1]}  #${state.myDrawings[index].gameWords[2]}',
                                            style: TextStyle(
                                              fontSize: 2.1.h,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                  },
                ),
        );
      },
    );
  }
}
