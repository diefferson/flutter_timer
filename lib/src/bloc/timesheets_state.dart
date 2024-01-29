import 'package:flutter_timer/src/domain/model/timer.dart';

class TimeSheetsState {
  final bool hasFavoriteTimers;
  final bool hasOdooTimers;
  final bool hasLocalTimers;

  TimeSheetsState({
    this.hasFavoriteTimers = false,
    this.hasOdooTimers = false,
    this.hasLocalTimers = false,
  });
}


sealed class TimeSheetsTabState {
  final List<OdooTimer> listTimers;

  TimeSheetsTabState(this.listTimers);
}

final class TimeSheetsLoadingState extends TimeSheetsTabState {
  TimeSheetsLoadingState() : super([]);
}

final class TimeSheetsEmptyState extends TimeSheetsTabState {
  TimeSheetsEmptyState() : super([]);
}

final class TimeSheetsSuccessState extends TimeSheetsTabState {
  TimeSheetsSuccessState(super.list);
}

final class TimeSheetsErrorState extends TimeSheetsTabState {
  TimeSheetsErrorState() : super([]);
}
