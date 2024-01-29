import 'package:bloc/bloc.dart';
import 'package:flutter_timer/src/bloc/create_timer_events.dart';
import 'package:flutter_timer/src/bloc/create_timer_states.dart';
import 'package:flutter_timer/src/data/odoo_repository.dart';
import 'package:flutter_timer/src/domain/model/timer.dart';
import 'package:flutter_timer/src/domain/model/project.dart';
import 'package:flutter_timer/src/domain/model/task.dart';
import 'package:flutter_timer/src/utils/base_bloc.dart';
import 'create_timer_page_actions.dart';

class CreateTimerBloc extends BaseBloc<CreateTimerEvent, CreateTimerState,
    CreateTimerPageActions> {
  final OdooRepository _repository;

  CreateTimerBloc(this._repository) : super(CreateTimerState()) {
    on<CreateTimerLoadProjectsEvent>(_loadProjects);
    on<CreateTimerSelectProjectEvent>(_selectProject);
    on<CreateTimerSelectTaskEvent>(_selectTask);
    on<CreateTimerToggleFavoriteEvent>(_toggleFavorite);
    on<CreateTimerSetDescriptionEvent>(_setDescription);
    on<CreateTimerCreatedEvent>(_createTimer);
  }

  @override
  void init() {
    super.init();
    add(CreateTimerLoadProjectsEvent());
  }

  void selectProject(OdooProject? project){
    add(CreateTimerSelectProjectEvent(project));
  }

  void selectTask(OdooTask? task){
    add(CreateTimerSelectTaskEvent(task));
  }

  void setDescription(String description){
    add(CreateTimerSetDescriptionEvent(description));
  }

  void favoriteToggle(){
    add(CreateTimerToggleFavoriteEvent());
  }

  void createTimer() {
    add(CreateTimerCreatedEvent());
  }

  Future _loadProjects(
    CreateTimerLoadProjectsEvent event,
    Emitter<CreateTimerState> emit,
  ) async {
    final projectsResult = await _repository.getProjects();
    projectsResult.fold(
      (l) {
        emit(state);
      },
      (r) {
        emit(
          getUpdatedState(
            projects: r,
            cleanProject: true,
            selectedProject: null,
          ),
        );
      },
    );
  }

  Future _createTimer(
      CreateTimerCreatedEvent event, Emitter<CreateTimerState> emit) async {
    final projectsResult = await _repository.addTimer(
      OdooTimer(
        taskId: state.selectedTask?.id,
        taskName: state.selectedTask?.name,
        projectName: state.selectedProject?.name,
        totalTime: 0,
        isRunning: false,
        color: state.selectedProject?.color,
        deadLine: state.selectedProject?.deadline,
        isFavorite: state.favorite,
        description: state.description,
      ),
    );
    projectsResult.fold((l) {
      emit(state);
    }, (r) {
      actions.successCreateTimer();
    });
  }

  Future _toggleFavorite(CreateTimerToggleFavoriteEvent event,
      Emitter<CreateTimerState> emit) async {
    emit(getUpdatedState(favorite: !state.favorite));
  }

  Future _setDescription(CreateTimerSetDescriptionEvent event,
      Emitter<CreateTimerState> emit) async {
    emit(getUpdatedState(description: event.description));
  }

  Future _selectProject(CreateTimerSelectProjectEvent event,
      Emitter<CreateTimerState> emit) async {
    emit(getUpdatedState(
        selectedProject: event.selectedProject,
        selectedTask: null,
        cleanTask: true));
    _loadTasks(event.selectedProject?.id ?? "", emit);
  }

  Future _selectTask(
      CreateTimerSelectTaskEvent event, Emitter<CreateTimerState> emit) async {
    emit(getUpdatedState(selectedTask: event.selectedTask));
  }

  Future _loadTasks(String projectId, Emitter<CreateTimerState> emit) async {
    final tasksResult = await _repository.getProjectTasks(projectId);
    tasksResult.fold((l) {
      emit(state);
    }, (r) {
      emit(getUpdatedState(tasks: r));
    });
  }

  CreateTimerState getUpdatedState({
    List<OdooProject>? projects,
    List<OdooTask>? tasks,
    OdooProject? selectedProject,
    OdooTask? selectedTask,
    String? description,
    bool? favorite,
    bool cleanTask = false,
    bool cleanProject = false,
  }) {
    return CreateTimerState(
      projects: projects ?? state.projects,
      tasks: tasks ?? state.tasks,
      selectedProject: cleanProject
          ? selectedProject
          : selectedProject ?? state.selectedProject,
      selectedTask:
          cleanTask ? selectedTask : selectedTask ?? state.selectedTask,
      description: description ?? state.description,
      favorite: favorite ?? state.favorite,
    );
  }
}
