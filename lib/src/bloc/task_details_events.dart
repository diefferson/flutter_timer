
sealed class TaskDetailsEvents {}

final class TaskDetailsLoadProjectEvent extends TaskDetailsEvents {}

final class TaskDetailsLoadCompletedTimers extends TaskDetailsEvents {}

final class TaskDetailsStartTimerEvent extends TaskDetailsEvents {}

final class TaskDetailsPauseTimerEvent extends TaskDetailsEvents {}

final class TaskDetailsStopTimerEvent extends TaskDetailsEvents {}



