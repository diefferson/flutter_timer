import 'package:flutter_timer/src/domain/model/project.dart';
import 'package:flutter_timer/src/domain/model/task.dart';

sealed class CreateTimerEvent {}

final class CreateTimerLoadProjectsEvent extends CreateTimerEvent {}

final class CreateTimerToggleFavoriteEvent extends CreateTimerEvent {}

final class CreateTimerSelectProjectEvent extends CreateTimerEvent {
  CreateTimerSelectProjectEvent(this.selectedProject);

  final OdooProject? selectedProject;
}

final class CreateTimerSelectTaskEvent extends CreateTimerEvent {
  CreateTimerSelectTaskEvent(this.selectedTask);

  final OdooTask? selectedTask;
}

final class CreateTimerSetDescriptionEvent extends CreateTimerEvent {
  CreateTimerSetDescriptionEvent(this.description);

  final String description;
}

final class CreateTimerCreatedEvent extends CreateTimerEvent {}
