import 'package:flutter_timer/src/domain/model/project.dart';
import 'package:flutter_timer/src/domain/model/task.dart';

class CreateTimerState {
  CreateTimerState({
    this.projects = const [],
    this.tasks = const [],
    this.selectedProject,
    this.selectedTask,
    this.description = "",
    this.favorite = false,
  });

  final List<OdooProject> projects;
  final List<OdooTask> tasks;
  final OdooProject? selectedProject;
  final OdooTask? selectedTask;
  final String description;
  final bool favorite;
}
