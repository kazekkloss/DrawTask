import 'dart:async';
import 'dart:convert';

import 'package:drawtask/sockets/auth_socket.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';
import '../models/user.dart';

// All functions activated from authBloc

class AuthRepository {
  final AuthSocket _authSocket = AuthSocket();

  // Sign Up function ------------------
  Future<User> signUp({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    Completer<User> completer = Completer<User>();
    try {
      User newUser = User(
        id: '',
        email: email,
        password: password,
        verify: 0,
      );

      http.Response res = await http.post(Uri.parse('$uri/api/sign_up'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: newUser.toJson());
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString(
                  'x-auth-token', jsonDecode(res.body)['token']);
              User user = User.fromJson(res.body);
              completer.complete(user);
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
      return User.empty;
    }
    User user = await completer.future;
    return user;
  }

  // Sign In function ------------------
  Future<User> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    Completer<User> completer = Completer<User>();
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
            User user = User.fromJson(res.body);
            print("sign in from repo - ${user.username}");
            if (context.mounted) {
              _authSocket.authSocket(context: context, userId: user.id);
            }
            completer.complete(user);
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
      return User.empty;
    }
    User user = await completer.future;
    return user;
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
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

// Set username -------------------
  Future<User> setUsername({
    required BuildContext context,
    required String username,
    required String avatar,
  }) async {
    User user = User.empty;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response res = await http.post(
        Uri.parse('$uri/api/set-username'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
        body: jsonEncode(
          {
            'username': username,
            'avatar': avatar,
          },
        ),
      );

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            user = User.fromJson(
              jsonEncode(
                jsonDecode(res.body),
              ),
            );
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    return user;
  }

  // Get user data -------------------
  Future<User> getUserData({
    required BuildContext context,
  }) async {
    User user = User.empty;
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
        if (context.mounted) {
          user = User.fromJson(res.body);
          _authSocket.authSocket(context: context, userId: user.id);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    return user;
  }

  // Logout -------------------
  Future<User> logout({required BuildContext context}) async {
    User userRes = User.empty;
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      if (context.mounted) {
        _authSocket.disconnectSocket(context: context);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    return userRes;
  }
}
