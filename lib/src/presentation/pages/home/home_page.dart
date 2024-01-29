import 'package:flutter/material.dart';
import 'package:flutter_timer/src/presentation/pages/home/home_tab_page.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_background.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_bottom_navigation_bar.dart';
import 'home_page_actions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Future push({required BuildContext context}) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (c) => const HomePage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageActions {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: backPressed,
      child: OdooBackground(
        child: Scaffold(
          body: _body(),
          bottomNavigationBar: OdooBottomNavigationBar(
            pages: HomeTabPage.values,
            currentPage: currentPage,
            onPageSelected: (page) {
              changePage(page);
            },
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return IndexedStack(
      index: HomeTabPage.values.indexOf(currentPage),
      children: HomeTabPage.values
          .map(
            (e) => e.getPage(
              openOtherTab: changePage,
              isCurrent: e == currentPage,
            ),
          )
          .toList(),
    );
  }
}
