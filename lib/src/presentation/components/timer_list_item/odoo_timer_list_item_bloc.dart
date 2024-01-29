import 'package:flutter_timer/src/bloc/timer_item_events.dart';
import 'package:flutter_timer/src/data/odoo_repository.dart';
import 'package:flutter_timer/src/domain/model/timer.dart';
import 'package:flutter_timer/src/utils/timer_controller_mixin.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class OdooTimerListItemBloc extends Bloc<TimerItemEvent, OdooTimer>
    with TimerControllerMixin {
  OdooTimerListItemBloc(
    this.repository,
    OdooTimer? odooTimer,
  ) : super(odooTimer ?? OdooTimer()) {
    on<PauseTimerEvent>(_pauseTimer);
    on<StartTimerEvent>(_startTimer);
    timerCounter();
  }

  @override
  OdooTimer get odooTimer => state;

  @override
  final OdooRepository repository;

  void playPauseTimer() {
    if (odooTimer.isRunning) {
      add(PauseTimerEvent());
    } else {
      add(StartTimerEvent());
    }
  }

  Future _startTimer(StartTimerEvent event, Emitter<OdooTimer> emit) async {
    startTimer(emit);
  }

  Future _pauseTimer(PauseTimerEvent event, Emitter<OdooTimer> emit) async {
    pauseTimer(emit);
  }
}
