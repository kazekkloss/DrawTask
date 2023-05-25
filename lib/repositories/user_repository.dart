import 'dart:convert';

import 'package:drawtask/blocs/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../config/config.dart';
import '../models/models.dart';

class UserRepository {
  // search users from text field -------------------------------------
  Future<List<User>> searchUsers({
    required BuildContext context,
    required String searchQuery,
  }) async {
    List<User> usersList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response res = await http
          .get(Uri.parse('$uri/api/user/search/$searchQuery'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              usersList.add(
                User.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    print(usersList);
    return usersList;
  }

// get list ------------------------------------------------------------

  Future<List<User>> getUsersList({
    required BuildContext context,
    required int currentListLength,
    required FriendsType friendsType,
  }) async {
    List<User> userList = [];
    try {
      print('działa');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response res = await http.post(
        Uri.parse('$uri/api/get_users'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
        body: jsonEncode(
          {
            'currentListLength': currentListLength,
            'friendsType': friendsType.toString(),
          },
        ),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              userList.add(
                User.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return userList;
  }

  Future<User> sendInvitation(
      {required BuildContext context, required String userId}) async {
    User user = User.empty;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response res = await http.post(
        Uri.parse('$uri/api/send_invitation_to_friend'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
        body: jsonEncode(
          {
            'userId': userId,
          },
        ),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            var resUser = User.fromJson(
              jsonEncode(
                jsonDecode(res.body),
              ),
            );
            user = resUser;
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      return User.empty;
    }
    return user;
  }

  Future<User> confirmInvitation(
      {required BuildContext context, required String userId}) async {
    User user = User.empty;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response res = await http.post(
        Uri.parse('$uri/api/confirm_invitation'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
        body: jsonEncode(
          {
            'userId': userId,
          },
        ),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            var resUser = User.fromJson(
              jsonEncode(
                jsonDecode(res.body),
              ),
            );
            user = resUser;
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return user;
  }

  void deleteFriend({
    required BuildContext context,
    required String userId,
    required int currentListLength,
    required FriendsType friendsType,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response res = await http.post(
        Uri.parse('$uri/api/delete_friend'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
        body: jsonEncode(
          {
            'userId': userId,
            'friendsType': friendsType.toString(),
          },
        ),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {},
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
