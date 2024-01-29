import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_timer/src/utils/extensions.dart';

class Strings {
  String get appName => 'Odoo';

  String get locale => 'en_US';

  String get appSlogan => 'Time management without obstacles';

  String get timesheetsLabel => 'Timesheets';

  String get projectsLabel => 'Projects';

  String get settingsLabel => 'Settings';

  String get emptyTimesheets => 'You don’t have any odoo timesheets';

  String get emptyTimesheetsSubtitle => 'Synchronize with odoo to get started';

  String get emptyFavoriteTimesheetsSubtitle =>
      'You can mark a timer as favorite either on the timer creation page or within an existing timer';

  String get emptyLocalTimesheetsSubtitle =>
      'Create a timer to to begin tracking time';

  String get getStarted => 'Get Started';

  String get favorites => 'Favorites';

  String get odoo => 'Odoo';

  String get local => 'Local';

  String get emptyLocalTimesheets => 'You don’t have any local timesheets';

  String get emptyFavoriteTimesheets => 'No favorited timers yet';

  String get createTimer => 'Create Timer';

  String get task => 'Task';

  String get project => 'Project';

  String get description => 'Description';

  String get makeFavorite => 'Make Favorite';

  String get requiredField => 'Required field';

  String get errorFavoriteTimesheets => 'Error to load favorited timers';

  String get errorOdooTimesheets => 'Error to load odoo timers';

  String get errorLocalTimesheets => 'Error to load local timers';

  String get errorSubtitleTimesheets =>
      'Something went wrong, but you can try again';

  String get tryAgain => 'Try again';

  String get zeroTime => '00:00';

  String get details => 'Details';

  String get deadLineLabel => 'Deadline';

  String get assignedTo => 'Assigned to';

  String get completedRecords => 'Completed Records';

  String startTime(DateTime? starTime) => 'Start Time ${ starTime?.toDateString(format: 'HH:mm') ?? "--"}';

  String deadLine(DateTime? dateTime) {
    return "Deadline ${dateTime?.toDateString()}";
  }
}
