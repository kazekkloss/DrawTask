import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';

class DurationTransformer extends StreamTransformerBase<Duration, String> {
  final BuildContext context;
  final String gameId;

  DurationTransformer(this.context, this.gameId);
  @override
  Stream<String> bind(Stream<Duration> stream) {
    return stream.map((duration) => formatDuration(duration));
  }

  String formatDuration(Duration duration) {
    final remainingTime = const Duration(hours: 12) - duration;

    if (remainingTime.isNegative) {
      context.read<GameBloc>().add(DeleteGameEvent(gameId: gameId));
      return '0';
    }

    if (remainingTime.inMinutes >= 60) {
      // Ostatnia godzina
      final hours = remainingTime.inHours + 1;
      return '${hours.toString()} h';
    } else if (remainingTime.inMinutes >= 1) {
      // Ostatnia minuta
      final minutes = remainingTime.inMinutes + 1;
      return '${minutes.toString()} m';
    } else {
      // Poniżej jednej minuty
      final seconds = remainingTime.inSeconds;
      return '${seconds.toString()} s';
    }
  }
}
