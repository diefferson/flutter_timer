import 'package:flutter_timer/src/domain/model/project.dart';
import 'package:flutter_timer/src/domain/model/timer.dart';

class TaskDetailsState {
  TaskDetailsState({
    OdooTimer? timer,
    OdooProject? project,
    List<OdooTimer>? completedTimers,
  })  : timer = timer ?? OdooTimer(),
        project = project ?? OdooProject(),
        completedTimers = completedTimers ?? [];

  final OdooTimer timer;
  final OdooProject project;
  final List<OdooTimer> completedTimers;
}
