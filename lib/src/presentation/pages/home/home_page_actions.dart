import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timer/src/presentation/pages/home/home_tab_page.dart';
import 'home_page.dart';

mixin HomePageActions on State<HomePage> {
  HomeTabPage currentPage = HomeTabPage.timesheets;

  void backPressed(bool didPop) {
    if (didPop) return;
    if (currentPage != HomeTabPage.timesheets) {
      changePage(HomeTabPage.timesheets);
    } else {
      SystemNavigator.pop();
    }
  }

  void changePage(HomeTabPage page) {
    if (currentPage != page) {
      setState(() {
        currentPage = page;
      });
    }
  }
}
