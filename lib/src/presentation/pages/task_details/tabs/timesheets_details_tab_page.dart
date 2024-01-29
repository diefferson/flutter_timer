import 'package:flutter/material.dart';
import 'package:flutter_timer/res/app_strings.dart';
import 'package:flutter_timer/src/domain/model/timer.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_text.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_timer_details_item.dart';
import 'package:flutter_timer/src/presentation/widgets/space.dart';

class TimesheetsDetailTabPage extends StatefulWidget {
  const TimesheetsDetailTabPage({
    super.key,
    required this.timers,
    required this.currentTimer,
    this.timerCounter,
    this.playPauseAction,
    this.stopAction,
  });

  final List<OdooTimer> timers;
  final OdooTimer currentTimer;
  final Stream<String>? timerCounter;
  final VoidCallback? playPauseAction;
  final VoidCallback? stopAction;

  @override
  State<TimesheetsDetailTabPage> createState() =>
      _TimesheetsDetailTabPageState();
}

class _TimesheetsDetailTabPageState extends State<TimesheetsDetailTabPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        OdooTimerDetailsItem(
          timer: widget.currentTimer,
          editDescriptionAction: () {},
          timerCounter: widget.timerCounter,
          playPauseAction: widget.playPauseAction,
          stopAction: widget.stopAction,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VSpace(16),
            OdooText(
              AppStrings.of(context).completedRecords,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const VSpace(8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.timers.length,
              itemBuilder: (context, index) {
                return OdooTimerDetailsItem(
                  timer: widget.timers[index],
                  editDescriptionAction: () {},
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
