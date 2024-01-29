import 'package:flutter_timer/src/domain/model/timer.dart';
import 'package:flutter_timer/src/presentation/pages/create_timer/create_timer_page.dart';
import 'package:flutter_timer/src/presentation/pages/task_details/task_details_page.dart';
import 'package:flutter_timer/src/presentation/pages/timesheets/timesheets_bloc.dart';
import 'package:flutter_timer/src/presentation/pages/timesheets/timesheets_page.dart';
import 'package:flutter_timer/src/utils/base_bloc.dart';

mixin TimeSheetsActions on BaseState<TimesheetsPage, TimesheetsBloc> {
  Future createTimer() async {
    final result = await CreateTimerPage.push(context: context);
    if (result == true) {
      bloc.refresh();
    }
  }

  Future goToTaskDetails(OdooTimer timer) async {
    final result = await TaskDetailsPage.push(context: context, timer: timer);
    if (result == true) {
      bloc.refresh();
    }
  }

  Future sortList() async {
    // TODO implement display bottom sheet
  }
}
