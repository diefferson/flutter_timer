import 'package:flutter/material.dart';
import 'package:flutter_timer/src/bloc/timesheets_state.dart';
import 'package:flutter_timer/src/domain/model/timer.dart';
import 'package:flutter_timer/src/presentation/components/timer_list_item/odoo_timer_list_item.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_empty_list.dart';

class TimesheetsTabPage extends StatefulWidget {
  const TimesheetsTabPage({
    super.key,
    required this.stateStream,
    required this.onTimerPressed,
    required this.emptyData,
    required this.errorData,
  });

  final Stream<TimeSheetsTabState> stateStream;
  final OdooEmptyListData emptyData;
  final OdooEmptyListData errorData;
  final Function(OdooTimer) onTimerPressed;

  @override
  State<TimesheetsTabPage> createState() => _TimesheetsTabPageState();
}

class _TimesheetsTabPageState extends State<TimesheetsTabPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TimeSheetsTabState>(
      stream: widget.stateStream,
      builder: (context, snapshot) {
        final state = snapshot.data ?? TimeSheetsLoadingState();

        if (state is TimeSheetsEmptyState) {
          return _emptyState();
        }

        if (state is TimeSheetsSuccessState) {
          return _successState(state.listTimers);
        }

        if (state is TimeSheetsErrorState) {
          return _errorState();
        }

        return _loadingState();
      },
    );
  }

  Widget _successState(List<OdooTimer> timers) {
    return ListView.builder(
      itemCount: timers.length,
      itemBuilder: (context, index) {
        return OdooTimerListItem(
          timer: timers[index],
          action: widget.onTimerPressed,
        );
      },
    );
  }

  Widget _emptyState() {
    return OdooEmptyList(
      data: widget.emptyData,
    );
  }

  Widget _loadingState() {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }

  Widget _errorState() {
    return OdooEmptyList(
      data: widget.errorData,
    );
  }
}
