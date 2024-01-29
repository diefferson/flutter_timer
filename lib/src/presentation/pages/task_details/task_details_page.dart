import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/res/app_icons.dart';
import 'package:flutter_timer/res/app_strings.dart';
import 'package:flutter_timer/src/bloc/task_details_state.dart';
import 'package:flutter_timer/src/domain/model/timer.dart';
import 'package:flutter_timer/src/presentation/pages/task_details/tabs/project_details_tab_page.dart';
import 'package:flutter_timer/src/presentation/pages/task_details/tabs/timesheets_details_tab_page.dart';
import 'package:flutter_timer/src/presentation/pages/task_details/taks_details_bloc.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_app_bar.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_background.dart';
import 'package:stark/stark.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({super.key, required this.timer});

  final OdooTimer timer;

  static Future<bool?> push({
    required BuildContext context,
    required OdooTimer timer,
  }) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => TaskDetailsPage(
          timer: timer,
        ),
      ),
    );
  }

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends InjectableState<TaskDetailsPage>
    with SingleTickerProviderStateMixin {

  late TaskDetailsBloc bloc;
  late TabController _tabController;
  int selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    bloc = get(params: {'odooTimer': widget.timer});
    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: selectedIndex,
    );
    bloc.loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OdooBackground(
      child: Scaffold(
        appBar: OdooAppBar(
          title: widget.timer.taskName,
          titleSize: 16,
          tabBar: _tabBar(context),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                AppIcons.pencil,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        ),
        body: _body(),
      ),
    );
  }

  TabBarView _body() {
    return TabBarView(
      controller: _tabController,
      children: [
        BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
          bloc: bloc,
          builder: (context, state) {
            return TimesheetsDetailTabPage(
              currentTimer: state.timer,
              timers: state.completedTimers,
              timerCounter: bloc.timerSeconds,
              playPauseAction: bloc.playPauseTimer,
              stopAction: bloc.stopTimer,
            );
          },
        ),
        BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
          bloc: bloc,
          builder: (context, state) {
            return ProjectDetailsTabPage(
              odooProject: state.project,
            );
          },
        ),
      ],
    );
  }

  TabBar _tabBar(BuildContext context) {
    return TabBar(
      controller: _tabController,
      tabs: [
        Tab(text: AppStrings.of(context).timesheetsLabel),
        Tab(text: AppStrings.of(context).details),
      ],
      indicatorWeight: 1,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 24),
      dividerColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
