import 'package:drawtask/blocs/auth/auth_bloc.dart';
import 'package:drawtask/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config.dart';

class CreateTab extends StatefulWidget {
  final VoidCallback voidSetDown;
  const CreateTab({
    required this.voidSetDown,
    super.key,
  });

  @override
  State<CreateTab> createState() => _CreateTabState();
}

class _CreateTabState extends State<CreateTab> {
  final _createTabFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  String selectedAvatar = '';

  void selectAvatar(String url) {
    setState(() {
      if (selectedAvatar == url) {
        selectedAvatar = '';
      } else {
        selectedAvatar = url;
      }
    });
    print(selectedAvatar);
  }

  Widget _avatar(String url) {
    final bool isSelected = selectedAvatar == url;
    return GestureDetector(
      onTap: () => selectAvatar(url),
      child: AnimatedContainer(
        height: isSelected ? 9.5.h : 7.h,
        duration: const Duration(milliseconds: 150),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Lottie.asset(url, fit: BoxFit.cover),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _createTabFormKey,
      child: Column(
        children: [
          SizedBox(
            width: 100.w,
            height: 2.4.h,
          ),
          SizedBox(
            width: SizerUtil.deviceType == DeviceType.mobile ? 84.w : 5.6.h * 7,
            child: Text('Enter Username',
                textAlign: TextAlign.left, style: TextStyle(fontSize: 2.h)),
          ),
          SizedBox(
            height: 1.3.h,
          ),
          SizedBox(
            width: SizerUtil.deviceType == DeviceType.mobile ? 84.w : 5.6.h * 7,
            height: 5.6.h,
            child: TextFormField(
              controller: _usernameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'username is empty';
                }
                if (value.length <= 3) {
                  return 'username is too short, min 4 characters';
                }
                return null;
              },
              decoration: textFormFieldDecoration(hintText: ''),
            ),
          ),
          SizedBox(
            height: 2.4.h,
          ),
          SizedBox(
            width: SizerUtil.deviceType == DeviceType.mobile ? 84.w : 5.6.h * 7,
            child: Text(
              'Choose Avatar',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 2.h),
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          SizedBox(
            width: SizerUtil.deviceType == DeviceType.mobile ? 84.w : 5.6.h * 7,
            height: 9.5.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _avatar('assets/avatars/purple_avatar.json'),
                _avatar('assets/avatars/pink_avatar.json'),
                _avatar('assets/avatars/green_avatar.json'),
                _avatar('assets/avatars/grey_avatar.json'),
              ],
            ),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          MainButton(
            onPressed: () {
              if (_createTabFormKey.currentState!.validate() &&
                  selectedAvatar.isNotEmpty) {
                FocusScope.of(context).requestFocus(FocusNode());
                widget.voidSetDown();
                Future.delayed(const Duration(milliseconds: 1000), () {
                  context.read<AuthBloc>().add(SaveUsernameEvent(
                      context: context,
                      username: _usernameController.text,
                      avatar: selectedAvatar));
                });
              }
            },
            text: 'NEXT',
          ),
        ],
      ),
    );
  }
}
