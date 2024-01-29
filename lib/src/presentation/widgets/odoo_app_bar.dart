import 'package:flutter/material.dart';
import 'package:flutter_timer/res/app_icons.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_text.dart';

import 'status_bar.dart';

class OdooHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OdooHomeAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.padding,
    this.tabBar,
  });

  final String title;
  final List<Widget> actions;
  final EdgeInsets? padding;
  final TabBar? tabBar;

  @override
  Size get preferredSize =>
      tabBar == null ? const Size.fromHeight(92) : const Size.fromHeight(143);

  @override
  Widget build(BuildContext context) {
    return LightStatusBar(
      child: _content(context),
    );
  }

  SafeArea _content(BuildContext context) {
    return SafeArea(
      bottom: false,
      right: false,
      left: false,
      child: Column(
        children: [
          Container(
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: OdooText(
                    title,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineLarge,
                  ),
                ),
                ...actions,
              ],
            ),
          ),
          tabBar ?? Container(),
        ],
      ),
    );
  }
}

class OdooAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OdooAppBar({
    super.key,
    required this.title,
    this.titleSize = 24,
    this.actions = const [],
    this.tabBar,
  });

  final String title;
  final List<Widget> actions;
  final double titleSize;
  final TabBar? tabBar;

  @override
  Size get preferredSize =>
      tabBar == null ? const Size.fromHeight(kToolbarHeight) : const Size
          .fromHeight(kToolbarHeight + 51);


  @override
  Widget build(BuildContext context) {
    return LightStatusBar(
      child: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return AppBar(
      title: OdooText(
        title,
        style: Theme
            .of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(
          fontSize: titleSize,
        ),
      ),
      actions: actions,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      bottom: tabBar,
      leading: IconButton(
        icon: const Icon(AppIcons.chevron_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      elevation: 0,
    );
  }
}
