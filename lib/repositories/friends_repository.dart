import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../blocs/blocs.dart';
import '../config/config.dart';
import '../models/models.dart';

class FriendsRepository {
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
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
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
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    return userList;
  }

  void sendInvitation(
      {required BuildContext context, required String userId}) async {
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
            context.read<FriendsBloc>().add(GetFriendsEvent(
                friendsType: FriendsType.waiting,
                context: context,
                listLength: 0));
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  void confirmInvitation(
      {required BuildContext context, required String userId}) async {
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
            context.read<FriendsBloc>().add(GetFriendsEvent(
                friendsType: FriendsType.invitations,
                context: context,
                listLength: 0));
            context.read<FriendsBloc>().add(GetFriendsEvent(
                friendsType: FriendsType.accepted,
                context: context,
                listLength: 0));
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
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
          onSuccess: () {
            if (friendsType == FriendsType.accepted) {
              context.read<FriendsBloc>().add(GetFriendsEvent(
                  friendsType: FriendsType.accepted,
                  context: context,
                  listLength: 0));
            }
            if (friendsType == FriendsType.waiting) {
              context.read<FriendsBloc>().add(GetFriendsEvent(
                  friendsType: FriendsType.waiting,
                  context: context,
                  listLength: 0));
            }
            if (friendsType == FriendsType.invitations) {
              context.read<FriendsBloc>().add(GetFriendsEvent(
                  friendsType: FriendsType.invitations,
                  context: context,
                  listLength: 0));
            }
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }
}
