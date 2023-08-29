import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../blocs/blocs.dart';
import '../../../../models/models.dart';
import '../../widgets/widgets.dart';

class ScoreTab extends StatelessWidget {
  final Picture picture;
  final VoidCallback onTap;
  const ScoreTab({super.key, required this.picture, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    bool isCurrenUserOwner = picture.userOwner.id == authBloc.state.user.id;
    return Padding(
      padding: EdgeInsets.only(left: 5.4.w, right: 5.4.w, top: 1.2.h),
      child: SmallTab(
        color: picture.userOwner.id == authBloc.state.user.id
            ? const Color(0xffd2b8f5)
            : const Color.fromRGBO(75, 75, 75, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0.7.h, left: 4.1.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    picture.userOwner.username.toString(),
                    style: TextStyle(
                      color: isCurrenUserOwner
                          ? const Color.fromARGB(255, 75, 75, 75)
                          : const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 21,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Score: ',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: isCurrenUserOwner
                                ? const Color.fromARGB(255, 75, 75, 75)
                                : const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      Text(
                        picture.points.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: isCurrenUserOwner
                              ? const Color.fromARGB(255, 75, 75, 75)
                              : const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            ImageButton(
              imageUrl: picture.imageUrl,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
