import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../cubits/cubits.dart';
import '../../../../models/models.dart';

class VoteNumbers extends StatelessWidget {
  final void Function(int) onTap;
  final String pictureId;
  final List<Vote> votes;
  const VoteNumbers(
      {super.key,
      required this.votes,
      required this.pictureId,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    print(votes);
    return SizedBox(
      width: 67.9.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 1; i <= 4; i++)
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => onTap(i),
                  child: Container(
                    height: 5.3.h,
                    width: 5.3.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          votes.any((v) => v.id == pictureId && v.point == i)
                              ? Border.all(
                                  color: state.themeData.primaryColor,
                                  width: 1,
                                )
                              : null,
                      color: votes.any((v) => v.id != pictureId && v.point == i)
                          ? const Color.fromARGB(101, 217, 217, 217)
                          : const Color(0xffd9d9d9),
                    ),
                    child: Center(
                      child: Text(
                        i.toString(),
                        style: TextStyle(
                          fontSize: 1.8.h,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
