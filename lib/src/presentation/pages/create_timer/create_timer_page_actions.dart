import 'package:flutter/cupertino.dart';
import 'package:flutter_timer/src/presentation/pages/create_timer/create_timer_bloc.dart';
import 'package:flutter_timer/src/presentation/pages/create_timer/create_timer_page.dart';
import 'package:flutter_timer/src/utils/base_bloc.dart';

mixin CreateTimerPageActions on BaseState<CreateTimerPage, CreateTimerBloc> {
  final GlobalKey<FormState> formKey = GlobalKey();

  void submitForm() {
    if (formKey.currentState?.validate() == true) {
      bloc.createTimer();
    }
  }

  void successCreateTimer() {
    if (mounted) {
      Navigator.of(context).pop(true);
    }
  }
}
