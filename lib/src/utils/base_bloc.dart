import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stark/stark.dart';



abstract class BaseBloc<Event, State, Actions> extends Bloc<Event, State>
    implements Disposable {
  BaseBloc(State initialState) : super(initialState);
  late Actions actions;

  void init(){ }

  @override
  void dispose() {}
}

abstract class BaseState<T extends StatefulWidget, B extends BaseBloc>
    extends InjectableState<T> {
  late B bloc;

  @override
  @mustCallSuper
  void initState() {
    bloc = get();
    bloc.actions = this;
    super.initState();
    bloc.init();
  }
}
