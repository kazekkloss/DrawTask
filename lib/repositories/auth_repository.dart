import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/blocs.dart';
import '../config/config.dart';
import '../models/user.dart';

// All functions activated from authBloc

class AuthRepository {
  // Sign Up function ------------------
  void signUp({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        email: email,
        password: password,
        verify: 0,
      );

      http.Response res = await http.post(Uri.parse('$uri/api/sign_up'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: user.toJson());
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              signIn(context: context, email: email, password: password);
            });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Sign In function ------------------
  void signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/sign_in'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () async {
              print(res.body);
              User user = User.fromJson(res.body);

              // get token to preferences
              Map<String, dynamic> token = jsonDecode(res.body);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString(
                  'x-auth-token', jsonDecode(res.body)['token']);

              if (context.mounted) {
                // Send user to state
                context.read<AuthBloc>().add(
                    UserProviderEvent(user: user, token: '${token['token']}'));
              }
            });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
