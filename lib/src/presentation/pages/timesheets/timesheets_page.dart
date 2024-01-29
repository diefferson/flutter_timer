import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/res/app_icons.dart';
import 'package:flutter_timer/res/app_images.dart';
import 'package:flutter_timer/res/app_strings.dart';
import 'package:flutter_timer/src/bloc/timesheets_state.dart';
import 'package:flutter_timer/src/presentation/pages/timesheets/tabs/timesheets_tab_page.dart';
import 'package:flutter_timer/src/presentation/pages/timesheets/timesheets_bloc.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_app_bar.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_app_bar_action.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_empty_list.dart';
import 'package:flutter_timer/src/utils/base_bloc.dart';

import 'timesheets_actions.dart';

class TimesheetsPage extends StatefulWidget {
  const TimesheetsPage({super.key});

  @override
  State<TimesheetsPage> createState() => _TimesheetsPageState();
}

class _TimesheetsPageState extends BaseState<TimesheetsPage, TimesheetsBloc>
    with TimeSheetsActions, SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 1,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool _showSortAction(TimeSheetsState state) {
    if (_tabController.index == 0 && state.hasFavoriteTimers) {
      return true;
    } else if (_tabController.index == 1 && state.hasOdooTimers) {
      return true;
    } else if (_tabController.index == 2 && state.hasLocalTimers) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OdooHomeAppBar(
        title: AppStrings.of(context).timesheetsLabel,
        actions: _appBarActions(),
        tabBar: _tabBar(context),
      ),
      body: _body(),
    );
  }

  List<Widget> _appBarActions() {
    return [
      BlocBuilder<TimesheetsBloc, TimeSheetsState>(
        bloc: bloc,
        builder: (context, state) {
          return Visibility(
            visible: _showSortAction(state),
            child: Container(
              padding: const EdgeInsets.only(right: 8),
              child: OdooAppBarAction(
                icon: AppIcons.invert,
                action: sortList,
              ),
            ),
          );
        },
      ),
      OdooAppBarAction(icon: AppIcons.plus, action: createTimer),
    ];
  }

  TabBar _tabBar(BuildContext context) {
    return TabBar(
      controller: _tabController,
      indicatorWeight: 1,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 24),
      dividerColor: Theme.of(context).colorScheme.secondary,
      tabs: [
        Tab(text: AppStrings.of(context).favorites),
        Tab(text: AppStrings.of(context).odoo),
        Tab(text: AppStrings.of(context).local),
      ],
    );
  }

  TabBarView _body() {
    return TabBarView(
      controller: _tabController,
      children: [
        _favoriteTab(),
        _odooTab(),
        _localTab(),
      ],
    );
  }

  TimesheetsTabPage _localTab() {
    return TimesheetsTabPage(
      stateStream: bloc.localState,
      onTimerPressed: goToTaskDetails,
      emptyData: OdooEmptyListData(
        image: AppImages.clock,
        title: AppStrings.of(context).emptyLocalTimesheets,
        description: AppStrings.of(context).emptyLocalTimesheetsSubtitle,
        actionLabel: AppStrings.of(context).getStarted,
        action: createTimer,
      ),
      errorData: OdooEmptyListData(
        image: AppImages.clock,
        title: AppStrings.of(context).errorLocalTimesheets,
        description: AppStrings.of(context).errorSubtitleTimesheets,
        actionLabel: AppStrings.of(context).tryAgain,
        action: bloc.reloadLocalTimers,
      ),
    );
  }

  TimesheetsTabPage _odooTab() {
    return TimesheetsTabPage(
      stateStream: bloc.odooState,
      onTimerPressed: goToTaskDetails,
      emptyData: OdooEmptyListData(
        image: AppImages.logo,
        title: AppStrings.of(context).emptyTimesheets,
        description: AppStrings.of(context).emptyTimesheetsSubtitle,
        actionLabel: AppStrings.of(context).getStarted,
        action: createTimer,
      ),
      errorData: OdooEmptyListData(
        image: AppImages.logo,
        title: AppStrings.of(context).errorOdooTimesheets,
        description: AppStrings.of(context).errorSubtitleTimesheets,
        actionLabel: AppStrings.of(context).tryAgain,
        action: bloc.reloadOdooTimers,
      ),
    );
  }

  TimesheetsTabPage _favoriteTab() {
    return TimesheetsTabPage(
      stateStream: bloc.favoriteState,
      onTimerPressed: goToTaskDetails,
      emptyData: OdooEmptyListData(
        image: AppImages.star,
        title: AppStrings.of(context).emptyFavoriteTimesheets,
        description: AppStrings.of(context).emptyFavoriteTimesheetsSubtitle,
        actionLabel: AppStrings.of(context).getStarted,
        action: createTimer,
      ),
      errorData: OdooEmptyListData(
        image: AppImages.star,
        title: AppStrings.of(context).errorFavoriteTimesheets,
        description: AppStrings.of(context).errorSubtitleTimesheets,
        actionLabel: AppStrings.of(context).tryAgain,
        action: bloc.reloadFavoriteTimers,
      ),
    );
  }
}
