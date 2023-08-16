import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle smallText = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      height: 1.5,
    );
    TextStyle boldText = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      height: 1.5,
    );
    return AnimatedTab(
        height: 52.8.h,
        child: Padding(
          padding: EdgeInsets.only(top: 2.3.h, left: 10.w, right: 10.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/hi.svg',
                    ),
                    const Text(
                      " Hello!",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Noto Sans',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.33.h),
                Text(
                  'We are a two-person team whose common denominator is passion. '
                  'We wanted to try to link our skills to create a mobile game and have fun at the same time!',
                  style: smallText,
                ),
                const SizedBox(height: 10.0),
                Text('Patrycja', style: boldText),
                Text(
                    'Currently working at Ocado technology as an Integration Engineer. '
                    'Enthusiast of UX/UI Design. Privately passion of sport and art.',
                    style: smallText),
                const SizedBox(height: 20.0),
                Text('Kazimierz', style: boldText),
                Text(
                  'Currently working at Software House as a Flutter Developer. '
                  'Enthusiast of Technology. Privately passion of history and sport.',
                  style: smallText,
                ),
              ],
            ),
          ),
        ));
  }
}
