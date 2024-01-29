import 'package:flutter/material.dart';
import 'package:flutter_timer/src/domain/model/project.dart';
import 'package:flutter_timer/src/domain/model/task.dart';
import 'package:flutter_timer/src/domain/model/timer.dart';
import 'package:flutter_timer/src/utils/extensions.dart';

class MockDataState {
  MockDataState({
    List<OdooProject>? listProjects,
    List<OdooTask>? listTasks,
    List<OdooTimer>? listTimers,
  })  : listProjects = listProjects ?? _projects,
        listTasks = listTasks ?? _tasks,
        listTimers = listTimers ?? _timers;

  final List<OdooProject> listProjects;

  final List<OdooTask> listTasks;

  final List<OdooTimer> listTimers;
}

final _projects = [
  OdooProject(
      id: 'project1',
      name: 'SO056 - BloioV2',
      color: Colors.yellow.toHex(),
      deadline: DateTime(2024, 05, 11),
      assignee: 'Ivan Zhuikov',
      isFavorite: true,
      description:
          'As a user, I would like to be able to buy a subscription, this would allow me to get a discount on the products and on the second stage of diagnosis'),
  OdooProject(
      id: 'project2',
      name: 'SO069: HL.cafe Maintenance',
      color: Colors.red.toHex(),
      deadline: DateTime(2024, 07, 7),
      isFavorite: false,
      assignee: 'Mark Stuart',
      description:
          'As a user, I would like to be able to buy a subscription, this would allow me to get a discount on the products and on the second stage of diagnosis')
];

final List<OdooTask> _tasks = [
  OdooTask(
    id: 'task1',
    projectId: 'project1',
    name: 'iOS app deployment with odd',
    description:
        'Sync with Client, communicate, work on the new design with designer, new tasks preparation call with the front end',
  ),
  OdooTask(
    id: 'task2',
    projectId: 'project1',
    name: 'Android app deployment with odd',
    description:
        'Sync with Client, communicate, work on the new design with designer, new tasks preparation call with the front end',
  ),
  OdooTask(
    id: 'task3',
    projectId: 'project2',
    name: 'iOS app deployment',
    description:
        'Sync with Client, communicate, work on the new design with designer, new tasks preparation call with the front end',
  ),
  OdooTask(
    id: 'task4',
    projectId: 'project2',
    name: 'Android app deployment',
    description:
        'Sync with Client, communicate, work on the new design with designer, new tasks preparation call with the front end',
  )
];

final List<OdooTimer> _timers = [
  OdooTimer(
    id: 'sampleTimer1',
    taskId: 'task1',
    taskName: 'iOS app deployment with odd',
    description:
        'Sync with Client, communicate, work on the new design with designer, new tasks preparation call with the front end',
    projectName: 'SO069: HL.cafe Maintenance',
    createdDate: DateTime(2024, 01, 18),
    isFavorite: false,
    completed: false,
    totalTime: 18800,
    isRunning: false,
    color: Colors.red.toHex(),
    deadLine: DateTime(2024, 07, 7),
    startTime: DateTime(2024, 01, 18, 10, 0, 0),
    lastStartedTime: DateTime(2024, 01, 28, 19, 0, 0),
  ),
  OdooTimer(
    id: 'sampleTimer2',
    taskId: 'task1',
    taskName: 'iOS app deployment with odd',
    projectName: 'SO069: HL.cafe Maintenance',
    createdDate: DateTime(2024, 01, 10),
    isFavorite: false,
    completed: true,
    totalTime: 28800,
    isRunning: false,
    color: Colors.red.toHex(),
    deadLine: DateTime(2024, 07, 7),
    startTime: DateTime(2024, 01, 10, 10, 0, 0),
    lastStartedTime: DateTime(2024, 01, 10, 19, 0, 0),
  ),
  OdooTimer(
    id: 'sampleTimer3',
    taskId: 'task1',
    taskName: 'iOS app deployment with odd',
    projectName: 'SO069: HL.cafe Maintenance',
    description:
        'As a user, I would like to be able to buy a subscription, this would allow me to get a discount on the products and on the second stage of diagnosis',
    createdDate: DateTime(2024, 01, 09),
    isFavorite: false,
    totalTime: 28800,
    isRunning: false,
    completed: true,
    color: Colors.red.toHex(),
    deadLine: DateTime(2024, 07, 7),
    startTime: DateTime(2024, 01, 09, 10, 0, 0),
    lastStartedTime: DateTime(2024, 01, 09, 19, 0, 0),
  ),
];
