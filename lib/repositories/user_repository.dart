import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../config/config.dart';
import '../models/models.dart';

class UserRepository {
  Future<List<User>> searchUsers({
    required BuildContext context,
    required String searchQuery,
  }) async {
    List<User> usersList = [];
    try {
        print("mniejsza");
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
              print("raz");
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
      // == tutaj ze jesli ta lista ma 10 indexow to daj zapytanie ale jesli nie to nie dawaj zeby nie pobierac calej bazy
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return usersList;
  }
}
