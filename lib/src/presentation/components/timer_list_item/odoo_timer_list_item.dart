import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/res/app_icons.dart';
import 'package:flutter_timer/res/app_strings.dart';
import 'package:flutter_timer/src/domain/model/timer.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_text.dart';
import 'package:flutter_timer/src/presentation/widgets/space.dart';
import 'package:flutter_timer/src/utils/extensions.dart';
import 'package:stark/stark.dart';
import 'odoo_timer_list_item_bloc.dart';

class OdooTimerListItem extends StatefulWidget {
  const OdooTimerListItem({super.key, required this.timer, required this.action});

  final OdooTimer timer;
  final Function(OdooTimer) action;

  @override
  State<OdooTimerListItem> createState() => _OdooTimerListItemState();
}

class _OdooTimerListItemState extends InjectableState<OdooTimerListItem>
    with SingleTickerProviderStateMixin {

  late OdooTimerListItemBloc bloc;


  @override
  void initState() {
    super.initState();
    bloc = get(params: {'odooTimer': widget.timer});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OdooTimerListItemBloc, OdooTimer>(
      bloc: bloc,
      builder: (context, state) {
        return GestureDetector(
          onTap: () => widget.action(state),
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 1,
                          color: HexColor.fromHex(state.color),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _iconLabel(
                          icon: AppIcons.play_arrow_solid,
                          label: state.taskName,
                          textStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                        _iconLabel(
                          icon: AppIcons.suitcase,
                          label: state.projectName,
                        ),
                        _iconLabel(
                          icon: AppIcons.clock,
                          label: AppStrings.of(context).deadLine(
                            state.deadLine,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _button(state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _iconLabel({
    required IconData icon,
    required String label,
    TextStyle? textStyle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
          ),
          const HSpace(8),
          Expanded(
            child: OdooText(
              label,
              style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(OdooTimer odooTimer) {
    return MaterialButton(
      onPressed: bloc.playPauseTimer,
      color: odooTimer.isRunning
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.secondary,
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64)),
      child: Row(
        children: [
          StreamBuilder<String>(
            stream: bloc.timerSeconds,
            builder: (context, snapshot) {
              return OdooText(
                snapshot.data ?? AppStrings.of(context).zeroTime,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: odooTimer.isRunning
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSecondary,
                    ),
              );
            },
          ),
          const HSpace(4),
          Icon(
            odooTimer.isRunning ? AppIcons.pause : AppIcons.play_arrow_solid,
            size: 22,
            color: odooTimer.isRunning
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSecondary,
          ),
        ],
      ),
    );
  }
}
