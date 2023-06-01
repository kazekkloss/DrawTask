import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/config/config.dart';
import '/models/models.dart';

part 'draw_event.dart';
part 'draw_state.dart';

class DrawBloc extends Bloc<DrawEvent, DrawState> {
  DrawBloc()
      : super(
          DrawState(
            listSketch: const <Sketch>[],
            sketch: Sketch(
              points: [],
              color: Colors.black,
              width: 10.0,
              mode: DrawingMode.pencil,
              filled: false,
            ),
          ),
        ) {
    on<OnStartEvent>(_onStartEventToState);
    on<OnUpdateEvent>(_onUpdateEventToState);
    on<OnEndEvent>(_onEndEventToState);
    on<SkechWidthEvent>(_skechWidthEventToState);
    on<ChangeColorEvent>(_changeColorEventToState);
    on<ChangeModeEvent>(_changeTypeEventToState);
    on<SetFillEvent>(_setFilledEventToState);
    on<UndoEvent>(_undoEventToState);
    on<ClearEvent>(_clearEventToState);
  }

  void _onStartEventToState(OnStartEvent event, Emitter<DrawState> emit) {
    try {
      final box = event.context.findRenderObject() as RenderBox;
      final offset = box.globalToLocal(event.details.localPosition);
      emit(DrawState(
          sketch: state.sketch.copyWith(points: [offset]),
          listSketch: state.listSketch));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onUpdateEventToState(OnUpdateEvent event, Emitter<DrawState> emit) {
    try {
      var sketch = state.sketch;
      final box = event.context.findRenderObject() as RenderBox;
      final offset = box.globalToLocal(event.details.localPosition);

      List<Offset> path = List.from(sketch.points)..add(offset);
      emit(DrawState(
          sketch: state.sketch.copyWith(points: path),
          listSketch: state.listSketch));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onEndEventToState(OnEndEvent event, Emitter<DrawState> emit) {
    try {
      var lines = List<Sketch>.from(state.listSketch)..add(state.sketch);
      emit(DrawState(sketch: state.sketch, listSketch: lines));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _skechWidthEventToState(SkechWidthEvent event, Emitter<DrawState> emit) {
    try {
      emit(DrawState(
          sketch: state.sketch.copyWith(points: [], width: event.width),
          listSketch: state.listSketch));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _changeColorEventToState(
      ChangeColorEvent event, Emitter<DrawState> emit) {
    try {
      emit(DrawState(
          sketch: state.sketch.copyWith(points: [], color: event.color),
          listSketch: state.listSketch));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _changeTypeEventToState(ChangeModeEvent event, Emitter<DrawState> emit) {
    try {
      emit(DrawState(
          sketch: state.sketch.copyWith(points: [], mode: event.mode),
          listSketch: state.listSketch));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _setFilledEventToState(SetFillEvent event, Emitter<DrawState> emit) {
    try {
      emit(DrawState(
          sketch: state.sketch.copyWith(points: [], filled: event.filled),
          listSketch: state.listSketch));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _undoEventToState(UndoEvent event, Emitter<DrawState> emit) {
    try {
      final listSketch = state.listSketch;
      if (listSketch.isNotEmpty) {
        listSketch.remove(listSketch.last);
      }
      emit(DrawState(
          sketch: state.sketch.copyWith(points: []), listSketch: listSketch));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _clearEventToState(ClearEvent event, Emitter<DrawState> emit) {
    try {
      emit(DrawState(
          sketch: state.sketch.copyWith(points: []), listSketch: const []));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
