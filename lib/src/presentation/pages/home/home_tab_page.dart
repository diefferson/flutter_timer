
import 'package:flutter/material.dart';
import 'package:flutter_timer/res/app_icons.dart';
import 'package:flutter_timer/res/app_strings.dart';
import 'package:flutter_timer/src/presentation/pages/projects/projects_page.dart';
import 'package:flutter_timer/src/presentation/pages/settings/settings_page.dart';
import 'package:flutter_timer/src/presentation/pages/timesheets/timesheets_page.dart';

enum HomeTabPage {
  timesheets,
  projects,
  settings;

  IconData get icon {
    switch (this) {
      case HomeTabPage.timesheets:
        return AppIcons.clock;
      case HomeTabPage.projects:
        return AppIcons.suitcase;
      case HomeTabPage.settings:
        return AppIcons.gear;
    }
  }

  IconData get selectedIcon {
    switch (this) {
      case HomeTabPage.timesheets:
        return AppIcons.selected_clock;
      case HomeTabPage.projects:
        return AppIcons.selected_suitcase;
      case HomeTabPage.settings:
        return AppIcons.selected_settings;
    }
  }

  String getLabel(BuildContext context) {
    switch (this) {
      case HomeTabPage.timesheets:
        return AppStrings.of(context).timesheetsLabel;
      case HomeTabPage.projects:
        return AppStrings.of(context).projectsLabel;
      case HomeTabPage.settings:
        return AppStrings.of(context).settingsLabel;
    }
  }

  Widget getPage({
    required Function(HomeTabPage) openOtherTab,
    bool isCurrent = false,
  }) {
    switch (this) {
      case HomeTabPage.timesheets:
        return const TimesheetsPage();
      case HomeTabPage.projects:
        return const ProjectsPage();
      case HomeTabPage.settings:
        return const SettingsPage();
    }
  }
}