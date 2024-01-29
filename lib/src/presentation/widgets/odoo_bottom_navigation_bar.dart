import 'package:flutter/material.dart';
import 'package:flutter_timer/res/app_icons.dart';
import 'package:flutter_timer/res/app_strings.dart';
import 'package:flutter_timer/src/presentation/pages/home/home_tab_page.dart';
import 'package:flutter_timer/src/presentation/pages/projects/projects_page.dart';
import 'package:flutter_timer/src/presentation/pages/settings/settings_page.dart';
import 'package:flutter_timer/src/presentation/pages/timesheets/timesheets_page.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_text.dart';
import 'package:flutter_timer/src/presentation/widgets/space.dart';

class OdooBottomNavigationBar extends StatelessWidget {
  const OdooBottomNavigationBar({
    super.key,
    required this.pages,
    required this.currentPage,
    required this.onPageSelected,
  });

  final HomeTabPage currentPage;
  final Function(HomeTabPage) onPageSelected;
  final List<HomeTabPage> pages;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: pages.map((e) => _tabBarItem(context, e)).toList(),
      ),
    );
  }

  Widget _tabBarItem(BuildContext context, HomeTabPage page) {
    return Expanded(
      child: InkWell(
        onTap: () => onPageSelected(page),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                page == currentPage ? page.selectedIcon : page.icon,
                size: 21,
              ),
              const VSpace(7),
              OdooText(
                page.getLabel(context),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
