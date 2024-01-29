import 'package:dio/dio.dart';
import 'package:flutter_timer/src/domain/model/timer.dart';
import 'package:flutter_timer/src/domain/model/project.dart';
import 'package:flutter_timer/src/domain/model/task.dart';

class OdooApi {
  OdooApi(this._dio);

  final Dio _dio;

  Future addProject(OdooProject project) async {
    await _dio.post(
      '/projects',
      data: project.toJson(),
    );
  }

  Future addTask(OdooTask task) async {
    await _dio.post(
      '/tasks',
      data: task.toJson(),
    );
  }

  Future addTimer(OdooTimer timer) async {
    await _dio.post(
      '/timers',
      data: timer.toJson(),
    );
  }

  Future<OdooProject?> getProject(String projectId) async {
    final response = await _dio.get('/projects/$projectId');
    return OdooProject.fromJson(response.data);
  }

  Future<OdooTask?> getTask(String taskId) async {
    final response = await _dio.get('/tasks/$taskId');
    return OdooTask.fromJson(response.data);
  }

  Future<OdooTimer?> getTimer(String timerId) async {
    final response = await _dio.get('/timer/$timerId');
    return OdooTimer.fromJson(response.data);
  }

  Future<List<OdooProject>> listProjects() async {
    final response = await _dio.get('/projects');
    return (response.data as List).map((e) => OdooProject.fromJson(e)).toList();
  }

  Future<List<OdooTask>> listTasks() async {
    final response = await _dio.get('/tasks');
    return (response.data as List).map((e) => OdooTask.fromJson(e)).toList();
  }

  Future<List<OdooTimer>> listTimers() async {
    final response = await _dio.get('/timers');
    return (response.data as List).map((e) => OdooTimer.fromJson(e)).toList();
  }

  Future<OdooProject?> updateProject(OdooProject project) async {
    final response = await _dio.put(
      '/projects/${project.id}',
      data: project.toJson(),
    );
    return OdooProject.fromJson(response.data);
  }

  Future<OdooTask?> updateTask(OdooTask task) async {
    final response = await _dio.put(
      '/tasks/${task.id}',
      data: task.toJson(),
    );
    return OdooTask.fromJson(response.data);
  }

  Future<OdooTimer?> updateTimer(OdooTimer timer) async {
    final response = await _dio.put(
      '/timers/${timer.id}',
      data: timer.toJson(),
    );
    return OdooTimer.fromJson(response.data);
  }

  Future<List<OdooTask>> listProjectTasks(String projectId) async {
    final response = await _dio.get('/projects/$projectId}/tasks');
    return (response.data as List).map((e) => OdooTask.fromJson(e)).toList();
  }


  Future<List<OdooTimer>> listTaskTimers(String taskId) async{
    final response = await _dio.get('/tasks/$taskId}/timers');
    return (response.data as List).map((e) => OdooTimer.fromJson(e)).toList();
  }
}
