import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../blocs/blocs.dart';
import '../config/config.dart';
import '../models/models.dart';

class DrawingsRepository {
  Future<List<Drawing>> getMyDrawings({required BuildContext context}) async {
    List<Drawing> drawingsList = [];
    try {
      final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response res = await http.post(
        Uri.parse('$uri/api/get_my_drawings'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
        body: jsonEncode(
          {
            'currentUserId': authBloc.state.user.id,
          },
        ),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            final List<dynamic> responseData = jsonDecode(res.body);
            for (int i = 0; i < responseData.length; i++) {
              drawingsList.add(
                Drawing.fromMap(
                    responseData[i]),
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
    return drawingsList;
  }
}
