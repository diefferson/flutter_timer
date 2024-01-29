import 'package:bloc/bloc.dart';
import 'package:flutter_timer/src/data/odoo_repository.dart';
import 'package:flutter_timer/src/bloc/timesheets_state.dart';
import 'package:flutter_timer/src/bloc/timesheets_events.dart';
import 'package:flutter_timer/src/utils/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'timesheets_actions.dart';

class TimesheetsBloc
    extends BaseBloc<TimeSheetsEvent, TimeSheetsState, TimeSheetsActions> {
  TimesheetsBloc(this._repository) : super(TimeSheetsState()) {
    on<AddTimerEvent>(_addTimer);
    on<RefreshTimersEvent>(_refreshTimers);
    on<RefreshLocalTimersEvent>(_loadLocalTimers);
    on<RefreshFavoriteTimersEvent>(_loadFavoriteTimers);
    on<RefreshOdooTimersEvent>(_loadOdooTimers);
  }

  final OdooRepository _repository;

  final _favoriteState = BehaviorSubject<TimeSheetsTabState>();

  Stream<TimeSheetsTabState> get favoriteState => _favoriteState.stream;

  final _odooState = BehaviorSubject<TimeSheetsTabState>();

  Stream<TimeSheetsTabState> get odooState => _odooState.stream;

  final _localState = BehaviorSubject<TimeSheetsTabState>();

  Stream<TimeSheetsTabState> get localState => _localState.stream;

  @override
  void init() {
    super.init();
    refresh();
  }

  @override
  void dispose() {
    _favoriteState.close();
    _odooState.close();
    _localState.close();
    super.dispose();
  }

  void refresh() {
    add(RefreshTimersEvent());
  }

  void reloadLocalTimers() {
    add(RefreshLocalTimersEvent());
  }

  void reloadOdooTimers() {
    add(RefreshOdooTimersEvent());
  }

  void reloadFavoriteTimers() {
    add(RefreshFavoriteTimersEvent());
  }

  void _refreshTimers(RefreshTimersEvent event, Emitter<TimeSheetsState> emit) {
    _loadFavoriteTimers(RefreshFavoriteTimersEvent(), emit);
    _loadLocalTimers(RefreshLocalTimersEvent(), emit);
    _loadOdooTimers(RefreshOdooTimersEvent(), emit);
  }

  Future _addTimer(
    AddTimerEvent event,
    Emitter<TimeSheetsState> emit,
  ) async {
    await _repository.addTimer(event.timer);
    add(RefreshTimersEvent());
  }

  Future _loadFavoriteTimers(
    RefreshFavoriteTimersEvent event,
    Emitter<TimeSheetsState> emit,
  ) async {
    _favoriteState.add(TimeSheetsLoadingState());
    final result = await _repository.getFavoriteTimers();
    result.fold(
      (l) {
        _favoriteState.add(TimeSheetsErrorState());
      },
      (r) {
        if (r.isEmpty) {
          _favoriteState.add(TimeSheetsEmptyState());
        } else {
          _favoriteState.add(TimeSheetsSuccessState(r));
        }
        emit(TimeSheetsState(
          hasFavoriteTimers: r.isNotEmpty,
          hasLocalTimers: state.hasLocalTimers,
          hasOdooTimers: state.hasOdooTimers,
        ));
      },
    );
  }

  Future _loadLocalTimers(
    RefreshLocalTimersEvent event,
    Emitter<TimeSheetsState> emit,
  ) async {
    _localState.add(TimeSheetsLoadingState());
    final result = await _repository.getLocalTimers();
    result.fold(
      (l) {
        _localState.add(TimeSheetsErrorState());
      },
      (r) {
        if (r.isEmpty) {
          _localState.add(TimeSheetsEmptyState());
        } else {
          _localState.add(TimeSheetsSuccessState(r));
        }
        emit(TimeSheetsState(
          hasLocalTimers: r.isNotEmpty,
          hasFavoriteTimers: state.hasFavoriteTimers,
          hasOdooTimers: state.hasOdooTimers,
        ));
      },
    );
  }

  Future _loadOdooTimers(
    RefreshOdooTimersEvent event,
    Emitter<TimeSheetsState> emit,
  ) async {
    _odooState.add(TimeSheetsLoadingState());
    final result = await _repository.getTimers();
    result.fold(
      (l) {
        _odooState.add(TimeSheetsErrorState());
      },
      (r) {
        if (r.isEmpty) {
          _odooState.add(TimeSheetsEmptyState());
        } else {
          _odooState.add(TimeSheetsSuccessState(r));
        }
        emit(TimeSheetsState(
          hasOdooTimers: r.isNotEmpty,
          hasLocalTimers: state.hasLocalTimers,
          hasFavoriteTimers: state.hasFavoriteTimers,
        ));
      },
    );
  }
}
