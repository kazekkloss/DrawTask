import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';

class CheckLinkScreen extends StatelessWidget {
  static const routeName = '/check-link-screen';
  const CheckLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Text(''),
          ),
        );
      },
    );
  }
}
