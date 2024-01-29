import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/src/bloc/task_details_events.dart';
import 'package:flutter_timer/src/bloc/task_details_state.dart';
import 'package:flutter_timer/src/data/odoo_repository.dart';
import 'package:flutter_timer/src/domain/model/timer.dart';
import 'package:flutter_timer/src/utils/timer_controller_mixin.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvents, TaskDetailsState>
    with TimerControllerMixin {
  TaskDetailsBloc(this.repository, OdooTimer timer)
      : super(TaskDetailsState(timer: timer)) {
    on<TaskDetailsLoadProjectEvent>(_getProject);
    on<TaskDetailsLoadCompletedTimers>(_getCompletedTimers);
    on<TaskDetailsStartTimerEvent>(_startTimer);
    on<TaskDetailsPauseTimerEvent>(_pauseTimer);
    on<TaskDetailsStopTimerEvent>(_finishTimer);
    timerCounter();
  }

  @override
  bool get expandedTime => true;

  @override
  OdooTimer get odooTimer => state.timer;

  @override
  final OdooRepository repository;

  void loadData() {
    add(TaskDetailsLoadProjectEvent());
    add(TaskDetailsLoadCompletedTimers());
  }

  void stopTimer() {
    add(TaskDetailsStopTimerEvent());
  }

  void playPauseTimer() {
    if (odooTimer.isRunning) {
      add(TaskDetailsPauseTimerEvent());
    } else {
      add(TaskDetailsStartTimerEvent());
    }
  }

  Future _getProject(
    TaskDetailsLoadProjectEvent event,
    Emitter<TaskDetailsState> emit,
  ) async {
    final result = await repository.getProjectByTaskId(state.timer.taskId);
    result.fold((l) => null, (r) {
      emit(TaskDetailsState(
        timer: state.timer,
        project: r,
        completedTimers: state.completedTimers,
      ));
    });
  }

  Future _getCompletedTimers(
    TaskDetailsLoadCompletedTimers event,
    Emitter<TaskDetailsState> emit,
  ) async {
    final result = await repository.getCompletedTimers(state.timer.taskId);
    result.fold((l) => null, (r) {
      emit(TaskDetailsState(
        timer: state.timer,
        project: state.project,
        completedTimers: r,
      ));
    });
  }

  Future _startTimer(
      TaskDetailsStartTimerEvent event, Emitter<TaskDetailsState> emit) async {
    startTimer((e) {
      emit(
        TaskDetailsState(
          timer: e,
          completedTimers: state.completedTimers,
          project: state.project,
        ),
      );
    });
  }

  Future _pauseTimer(
      TaskDetailsPauseTimerEvent event, Emitter<TaskDetailsState> emit) async {
    pauseTimer((e) {
      emit(
        TaskDetailsState(
          timer: e,
          completedTimers: state.completedTimers,
          project: state.project,
        ),
      );
    });
  }

  Future _finishTimer(
      TaskDetailsStopTimerEvent event, Emitter<TaskDetailsState> emit) async {
    final updatedTimer = _getUpdatedTimer(
      isRunning: false,
      completed: true,
      startTime: null,
      totalTime: state.timer.totalTime += getRunningTime(),
    );
    final result = await repository.updateTimer(updatedTimer);
    result.fold(
      (l) {
        timerCounter();
      },
      (r) {
        emit(
          TaskDetailsState(
            timer: r,
            completedTimers: state.completedTimers,
            project: state.project,
          ),
        );
        timerCounter();
      },
    );
  }

  OdooTimer _getUpdatedTimer({
    required bool isRunning,
    bool completed = false,
    DateTime? startTime,
    required int totalTime,
  }) {
    return OdooTimer(
      id: state.timer.id,
      taskId: state.timer.taskId,
      taskName: state.timer.taskName,
      isFavorite: state.timer.isFavorite,
      projectName: state.timer.projectName,
      totalTime: totalTime,
      isRunning: isRunning,
      color: state.timer.color,
      startTime: state.timer.startTime ?? startTime,
      lastStartedTime: startTime,
      deadLine: state.timer.deadLine,
      completed: completed,
      description: state.timer.description,
      createdDate: state.timer.createdDate,
    );
  }
}
