import 'package:flutter_timer/src/utils/extensions.dart';
import 'package:uuid/uuid.dart';

class OdooTimer {
  OdooTimer({
    String? id,
    String? taskId,
    String? taskName,
    String? description,
    String? projectName,
    DateTime? createdDate,
    bool? isFavorite,
    int? totalTime,
    bool? isRunning,
    bool? completed,
    String? color,
    this.deadLine,
    this.startTime,
    this.lastStartedTime,
  })  : id = id ?? const Uuid().v1(),
        taskId = taskId ?? "",
        taskName = taskName ?? "",
        description = description ?? "",
        createdDate = createdDate ?? DateTime.now(),
        isFavorite = isFavorite ?? false,
        projectName = projectName ?? "",
        totalTime = totalTime ?? 0,
        isRunning = isRunning ?? false,
        completed = completed ?? false,
        color = color ?? "";

  final String id;
  String taskId;
  String taskName;
  String description;
  String projectName;
  DateTime createdDate;
  bool isFavorite;
  int totalTime;
  bool isRunning;
  bool completed;
  String color;
  DateTime? deadLine;
  DateTime? startTime;
  DateTime? lastStartedTime;

  factory OdooTimer.fromJson(Map<dynamic, dynamic> json) {
    return OdooTimer(
      id: json.getString('id'),
      taskId: json.getString('taskId'),
      taskName: json.getString('taskName'),
      description: json.getString('description'),
      projectName: json.getString('projectName'),
      createdDate: json.getDate('createdDate'),
      isFavorite: json.getBool('isFavorite'),
      totalTime: json.getInt('totalTime'),
      isRunning: json.getBool('isRunning'),
      completed: json.getBool('completed'),
      color: json.getString('color'),
      deadLine: json.getDate('deadLine'),
      startTime: json.getDate('startedTime'),
      lastStartedTime: json.getDate('lastStartedTime'),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'taskId': taskId,
        'taskName': taskName,
        'description': description,
        'projectName': projectName,
        'createdDate': createdDate.toIso8601String(),
        'isFavorite': isFavorite,
        'totalTime': totalTime,
        'isRunning': isRunning,
        'completed': completed,
        'color': color,
        'deadLine': deadLine?.toIso8601String(),
        'startTime': startTime?.toIso8601String(),
        'lastStartedTime': lastStartedTime?.toIso8601String(),
      }..removeWhere((e, dynamic v) => v == null);
}
