import 'dart:async';

import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/blocs.dart';
import '../../../repositories/repositories.dart';

class VerifyTab extends StatefulWidget {
  const VerifyTab({
    super.key,
  });

  @override
  State<VerifyTab> createState() => _VerifyTabState();
}

class _VerifyTabState extends State<VerifyTab> {
  late RiveAnimationController _controller;

  /// Is the animation currently playing?
  bool _isPlaying = false;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startChecking();
    _controller = OneShotAnimation(
      'Timeline 1',
      autoplay: false,
      onStop: () => setState(() => _isPlaying = false),
      onStart: () => setState(() => _isPlaying = true),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _stopChecking();
  }

  void _startChecking() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _checking();
    });
  }

  void _stopChecking() {
    _timer?.cancel();
  }

  void _checking() {
    context.read<AuthBloc>().add(CheckAuthEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status != AuthStatus.notVerified) {
          _stopChecking();
        }
      },
      child: SizedBox(
        width: 100.w,
        child: SizedBox(
          height: 43.9.h,
          child: Column(
            children: [
              SizedBox(
                height: 2.3.h,
              ),
              Container(
                width: SizerUtil.deviceType == DeviceType.mobile
                    ? 84.w
                    : 5.6.h * 7,
                height: 11.3.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                      blurRadius: 6,
                      color: Color.fromRGBO(195, 195, 195, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: 'Please check your e-mail and click ',
                            style: TextStyle(fontSize: 2.h)),
                        TextSpan(
                          text: 'link',
                          style: TextStyle(
                            fontSize: 2.h,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                            text: ' to activate your account.',
                            style: TextStyle(fontSize: 2.h)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.2.h,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return MainButton(
                    onPressed: () {
                      _isPlaying ? null : _controller.isActive = true;
                      AuthRepository().resendMail(
                          context: context,
                          email: state.user.email,
                          userId: state.user.id);
                    },
                    text: 'SEND LINK AGAIN',
                  );
                },
              ),
              SizedBox(
                height: 1.4.h,
              ),
              SizedBox(
                width: SizerUtil.deviceType == DeviceType.mobile
                    ? 84.w
                    : 5.6.h * 7,
                child: const Text(
                  "Don't you have a link?",
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 7.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 8.5.h,
                      width: 8.5.h,
                      child: RiveAnimation.asset(
                        'assets/animations/post.riv',
                        animations: const ['Timeline 1'],
                        fit: BoxFit.cover,
                        controllers: [_controller],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
