import 'package:flutter/material.dart';
import 'package:flutter_timer/res/app_icons.dart';
import 'package:flutter_timer/res/app_strings.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_app_bar.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_app_bar_action.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: selectedIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OdooHomeAppBar(
        title: AppStrings.of(context).projectsLabel,
        actions: [
          OdooAppBarAction(icon: AppIcons.plus, action: () {}),
        ],
        tabBar: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: AppStrings.of(context).favorites),
            Tab(text: AppStrings.of(context).odoo),
            Tab(text: AppStrings.of(context).local),
          ],
          indicatorWeight: 1,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 24),
          dividerColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
