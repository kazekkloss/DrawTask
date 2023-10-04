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
    on<GetMyDrawingsEvent>(_getMyDrawingsEventToState);
    on<GetWallDrawingsEvent>(_getWallDrawingsEventState);
  }

  void _getMyDrawingsEventToState(GetMyDrawingsEvent event, Emitter<DrawingsState> emit) async {
    try {
      List<Drawing> drawings = await _drawingsRepository.getMyDrawings(context: event.context);
      emit(state.copyWith(status: DrawingsStatus.loaded, myDrawings: drawings));
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _getWallDrawingsEventState(GetWallDrawingsEvent event, Emitter<DrawingsState> emit) async {
    try {
      List<Drawing> drawings = await _drawingsRepository.getWallDrawings(context: event.context);
      emit(state.copyWith(status: DrawingsStatus.loaded, wallDrawings: drawings));
    } catch (e) {
      debugPrint('$e');
    }
  }
}
