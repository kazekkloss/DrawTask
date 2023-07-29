import 'package:bloc/bloc.dart';
import 'package:drawtask/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../repositories/repositories.dart';

part 'drawings_event.dart';
part 'drawings_state.dart';

class DrawingsBloc extends Bloc<DrawingsEvent, DrawingsState> {
  final DrawingsRepository _drawingsRepository;
  DrawingsBloc({required DrawingsRepository drawingsRepository})
      : _drawingsRepository = drawingsRepository,
        super(const DrawingsState.loading()) {
    on<GetMyDrawingsEvent>(_testEventToState);
  }

  void _testEventToState(
      GetMyDrawingsEvent event, Emitter<DrawingsState> emit) async {
    try {
      List<Drawing> drawings =
          await _drawingsRepository.getMyDrawings(context: event.context);
      emit(DrawingsState.loaded(drawings));
    } catch (e) {
      debugPrint('$e');
    }
  }
}
