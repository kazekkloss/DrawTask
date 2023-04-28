import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';
import '../models/user.dart';

// All functions activated from authBloc

class AuthRepository {
  // Sign Up function ------------------
  Future<User> signUp({
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
            onSuccess: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString(
                  'x-auth-token', jsonDecode(res.body)['token']);
            });
      }
      return User.fromJson(res.body);
    } catch (e) {
      showSnackBar(context, e.toString());
      return User.empty;
    }
  }

  // Sign In function ------------------
  Future<User> signIn({
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
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString(
                  'x-auth-token', jsonDecode(res.body)['token']);
            });
      }
      return User.fromJson(res.body);
    } catch (e) {
      showSnackBar(context, e.toString());
      return User.empty;
    }
  }

  // Send mail ------------------
  void resendMail(
      {required BuildContext context,
      required String email,
      required String userId}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/resend_mail'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'userId': userId}),
      );
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              showSnackBar(context, "Email is send on $email");
            });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Get user data -------------------
  Future<User> getUserData({
    required BuildContext context,
  }) async {
    User userRes = User.empty;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/token-is-valid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response res = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );
        print(res.body);
        userRes = User.fromJson(res.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return userRes;
  }

  // Logout -------------------
  Future<User> logout({required BuildContext context}) async {
    User userRes = User.empty;
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return userRes;
  }
}
