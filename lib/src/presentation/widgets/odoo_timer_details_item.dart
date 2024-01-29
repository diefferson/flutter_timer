import 'package:flutter/material.dart';
import 'package:flutter_timer/res/app_icons.dart';
import 'package:flutter_timer/res/app_strings.dart';
import 'package:flutter_timer/src/domain/model/timer.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_text.dart';
import 'package:flutter_timer/src/presentation/widgets/space.dart';
import 'package:flutter_timer/src/utils/extensions.dart';

class OdooTimerDetailsItem extends StatelessWidget {
  const OdooTimerDetailsItem({
    super.key,
    required this.timer,
    required this.editDescriptionAction,
    this.timerCounter,
    this.playPauseAction,
    this.stopAction,
  });

  final OdooTimer timer;
  final VoidCallback editDescriptionAction;
  final Stream<String>? timerCounter;
  final VoidCallback? playPauseAction;
  final VoidCallback? stopAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: timer.completed,
                child: const Row(
                  children: [
                    Icon(AppIcons.completed, size: 20),
                    HSpace(8),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OdooText(
                      timer.createdDate
                          .toDateString(format: DateExtensions.weekDayFormat),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const VSpace(4),
                    OdooText(
                      timer.createdDate
                          .toDateString(format: DateExtensions.dateDotsFormat),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const VSpace(4),
                    OdooText(
                      AppStrings.of(context).startTime(timer.startTime),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: timer.completed,
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: OdooText(
                    secondsToString(timer.totalTime),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: !timer.completed,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: StreamBuilder<String>(
                      stream: timerCounter,
                      builder: (context, snapshot) {
                        return OdooText(
                          snapshot.data ?? "",
                          style: Theme.of(context).textTheme.displaySmall,
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: stopAction,
                    borderRadius: BorderRadius.circular(64),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Theme.of(context).colorScheme.secondaryContainer),
                      child: const Icon(
                        AppIcons.stop_fill,
                        size: 24,
                      ),
                    ),
                  ),
                  const HSpace(16),
                  InkWell(
                    onTap: playPauseAction,
                    borderRadius: BorderRadius.circular(64),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: timer.isRunning
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondaryContainer,
                      ),
                      child: timer.isRunning
                          ? Icon(
                              AppIcons.pause,
                              color: timer.isRunning
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onSecondary,
                            )
                          : const Icon(AppIcons.play_arrow_solid),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: timer.description.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VSpace(8),
                const Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: OdooText(
                        AppStrings.of(context).description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    IconButton(
                      onPressed: editDescriptionAction,
                      visualDensity: VisualDensity.compact,
                      iconSize: 24,
                      icon: const Icon(
                        AppIcons.pencil,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                OdooText(
                  timer.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
