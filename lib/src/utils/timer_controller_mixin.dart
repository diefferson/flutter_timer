import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutter_timer/src/data/odoo_repository.dart';
import 'package:flutter_timer/src/domain/model/timer.dart';
import 'package:flutter_timer/src/utils/extensions.dart';
import 'package:rxdart/subjects.dart';
import 'package:stark/stark.dart';

mixin TimerControllerMixin<Event, State> on Bloc<Event, State>
    implements Disposable {
  OdooRepository get repository;

  OdooTimer get odooTimer;

  final _timerSeconds = BehaviorSubject<String>();

  Stream<String> get timerSeconds => _timerSeconds.stream;

  Timer? _timer;

  bool get expandedTime => false;

  @override
  void dispose() {
    _timer?.cancel();
  }

  void timerCounter() {
    final secondsString = _getFormattedTime(odooTimer.totalTime);
    _timerSeconds.add(secondsString);
    if (odooTimer.isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        final seconds = getRunningTime();
        final secondsString = _getFormattedTime(odooTimer.totalTime + seconds);
        _timerSeconds.add(secondsString);
      });
    } else {
      _timer?.cancel();
    }
  }

  int getRunningTime() {
    var startDate = odooTimer.lastStartedTime ?? DateTime.now();
    final runningTime = DateTime.now().difference(startDate).inSeconds;
    return runningTime;
  }

  Future startTimer(Function(OdooTimer) onComplete) async {
    final updatedTimer = _getUpdatedState(
      state: odooTimer,
      isRunning: true,
      startTime: DateTime.now(),
      totalTime: odooTimer.totalTime,
    );
    final result = await repository.updateTimer(updatedTimer);
    result.fold(
      (l) {
        timerCounter();
      },
      (r) {
        onComplete(r);
        timerCounter();
      },
    );
  }

  Future pauseTimer(Function(OdooTimer) onComplete) async {
    final updatedTimer = _getUpdatedState(
      state: odooTimer,
      isRunning: false,
      startTime: null,
      totalTime: odooTimer.totalTime += getRunningTime(),
    );
    final result = await repository.updateTimer(updatedTimer);
    result.fold(
      (l) {
        timerCounter();
      },
      (r) {
        onComplete(r);
        timerCounter();
      },
    );
  }

  String _getFormattedTime(int seconds) {
    if (expandedTime) {
      return secondsToCompleteString(seconds);
    } else {
      return secondsToString(seconds);
    }
  }

  OdooTimer _getUpdatedState({
    required OdooTimer state,
    required bool isRunning,
    DateTime? startTime,
    required int totalTime,
  }) {
    return OdooTimer(
      id: state.id,
      taskId: state.taskId,
      taskName: state.taskName,
      isFavorite: state.isFavorite,
      projectName: state.projectName,
      totalTime: totalTime,
      isRunning: isRunning,
      color: state.color,
      startTime: state.startTime ?? startTime,
      lastStartedTime: startTime,
      deadLine: state.deadLine,
      completed: state.completed,
      description: state.description,
      createdDate: state.createdDate,
    );
  }
}
