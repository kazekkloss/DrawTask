import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/config.dart';
import '../models/user.dart';

class AuthRepository {
  // Sign Up function
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

      http.Response res = await http.post(Uri.parse('$uri/api/register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: user.toJson());
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              print('success');
            });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
