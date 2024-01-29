import 'package:flutter_timer/src/data/api/odoo_api.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_timer/src/data/mock_data_state.dart';
import 'package:flutter_timer/src/domain/model/project.dart';
import 'package:flutter_timer/src/domain/model/task.dart';
import 'package:flutter_timer/src/domain/model/timer.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class OdooRepository extends HydratedCubit<MockDataState> {
  OdooRepository(this._api) : super(MockDataState());

  final OdooApi _api;

  Future<Either<Exception, OdooTimer>> addTimer(OdooTimer timer) async {
    emit(
      MockDataState(
        listProjects: state.listProjects,
        listTasks: state.listTasks,
        listTimers: _addOrUpdateTimers(timer),
      ),
    );
    return Right(timer);
  }

  Future<Either<Exception, OdooTimer>> updateTimer(OdooTimer timer) async {
    emit(
      MockDataState(
        listProjects: state.listProjects,
        listTasks: state.listTasks,
        listTimers: _addOrUpdateTimers(timer),
      ),
    );
    return Right(timer);
  }

  Future<Either<Exception, List<OdooTimer>>> getTimers() async {
    return Right(state.listTimers.where((e) => !e.completed).toList());
  }

  Future<Either<Exception, List<OdooTimer>>> getCompletedTimers(
      String taskId) async {
    return Right(state.listTimers
        .where((e) => e.completed && e.taskId == taskId)
        .toList());
  }

  Future<Either<Exception, List<OdooTimer>>> getLocalTimers() async {
    return Left(Exception("Example exception"));
  }

  Future<Either<Exception, List<OdooTimer>>> getFavoriteTimers() async {
    return Right(
        state.listTimers.where((e) => e.isFavorite && !e.completed).toList());
  }

  Future<Either<Exception, List<OdooProject>>> getProjects() async {
    return Right(state.listProjects);
  }

  Future<Either<Exception, OdooProject>> getProjectByTaskId(
    String taskId,
  ) async {
    final task = state.listTasks.firstWhere((e) => e.id == taskId);
    return Right(state.listProjects.firstWhere((e) => e.id == task.projectId));
  }

  Future<Either<Exception, List<OdooTask>>> getProjectTasks(
      String projectId) async {
    return Right(
        state.listTasks.where((e) => e.projectId == projectId).toList());
  }

  List<OdooTimer> _addOrUpdateTimers(OdooTimer update) {
    final list = state.listTimers;
    final index = list.indexWhere((e) => e.id == update.id);
    if (index > -1) {
      list[index] = update;
    } else {
      list.add(update);
    }
    return list;
  }

  @override
  MockDataState? fromJson(Map<String, dynamic> json) {
    return MockDataState(
      listProjects: (json['projects'] as List)
          .map((e) => OdooProject.fromJson(e))
          .toList(),
      listTasks:
          (json['tasks'] as List).map((e) => OdooTask.fromJson(e)).toList(),
      listTimers:
          (json['timers'] as List).map((e) => OdooTimer.fromJson(e)).toList(),
    );
  }

  @override
  Map<String, dynamic>? toJson(MockDataState state) {
    return {
      'projects': state.listProjects.map((e) => e.toJson()).toList(),
      'tasks': state.listTasks.map((e) => e.toJson()).toList(),
      'timers': state.listTimers.map((e) => e.toJson()).toList(),
    };
  }
}
