import 'package:flutter_timer/src/domain/model/timer.dart';

sealed class TimeSheetsEvent {}

final class RefreshTimersEvent extends TimeSheetsEvent {}

final class RefreshLocalTimersEvent extends TimeSheetsEvent {}

final class RefreshFavoriteTimersEvent extends TimeSheetsEvent {}

final class RefreshOdooTimersEvent extends TimeSheetsEvent {}

final class AddTimerEvent extends TimeSheetsEvent {
  final OdooTimer timer;

  AddTimerEvent({required this.timer});
}
