import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/app/repositories/task_connect_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'tasklist_event.dart';

part 'tasklist_state.dart';

part 'tasklist_bloc.freezed.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final TaskConnectRepository _taskRepository;

  TaskListBloc({
    required TaskConnectRepository taskRepository,
  })  : _taskRepository = taskRepository,
        super(const TaskListState.loading()) {
    on<GetListEvent>(_onGetList);
    on<DeleteTaskEvent>(_onDelete);
    on<CreateTaskEvent>(_onCreate);
    on<EditTaskEvent>(_onEdit);
  }

  Future getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      const deviceType = 'ANDROID';
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      final deviceName = androidInfo.model ?? '';
      return '$deviceType $deviceName';
    } else if (Platform.isIOS) {
      const deviceType = 'IOS';
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      final deviceName = iosInfo.model ?? '';
      return '$deviceType $deviceName';
    }
  }

  Future<void> _onEdit(EditTaskEvent event, Emitter<TaskListState> emit) async {
    try {
      final task = event.task.copyWith(
        changedAt: DateTime.now().microsecondsSinceEpoch,
        lastUpdatedBy: await getDeviceInfo(),
      );
      if (state is TaskListLoadedState) {
        final currentState = state as TaskListLoadedState;
        final List<Task> newTasks = List.from(currentState.tasks);
        for (int i = 0; i < newTasks.length; i++) {
          if (newTasks[i].id == event.task.id) {
            newTasks[i] = task;
            break;
          }
        }
        emit(
          TaskListState.loaded(
            tasks: newTasks,
          ),
        );
        await _taskRepository.editTask(task: task);
      }
    } on DioError catch (e) {
      if (e.error != SocketException) {
        final currentState = state as TaskListErrorState;
        emit(
          TaskListState.error(
            tasks: currentState.tasks,
            message: e.toString(),
          ),
        );
      }
    } catch (e) {
      final currentState = state as TaskListErrorState;
      emit(TaskListState.error(
          message: e.toString(), tasks: currentState.tasks));
      //rethrow;
    }
  }

  Future<void> _onCreate(
      CreateTaskEvent event, Emitter<TaskListState> emit) async {
    if (event.text != '') {
      Task task = Task(
        id: const Uuid().v1(),
        text: event.text,
        done: false,
        importance: event.importance ?? Priority.basic,
        deadline: event.deadline,
        changedAt: DateTime.now().microsecondsSinceEpoch,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        lastUpdatedBy: await getDeviceInfo(),
      );
      try {
        if (state is TaskListLoadedState) {
          final currentState = state as TaskListLoadedState;
          final List<Task> newTasks = List.from(currentState.tasks);
          newTasks.add(task);

          emit(
            TaskListState.loaded(
              tasks: newTasks,
            ),
          );
          await _taskRepository.createTask(task: task);
        }
      } on DioError catch (e) {
        if (e.error != SocketException) {
          final currentState = state as TaskListErrorState;
          emit(
            TaskListState.error(
              tasks: currentState.tasks,
              message: e.toString(),
            ),
          );
        }
      } catch (e) {
        final currentState = state as TaskListErrorState;
        emit(TaskListState.error(
            message: e.toString(), tasks: currentState.tasks));
      }
    }
  }

  Future<void> _onDelete(
      DeleteTaskEvent event, Emitter<TaskListState> emit) async {
    try {
      if (state is TaskListLoadedState) {
        final currentState = state as TaskListLoadedState;
        final List<Task> newTasks = List.from(currentState.tasks);
        newTasks.remove(event.task);

        emit(
          TaskListState.loaded(
            tasks: newTasks,
          ),
        );
        await _taskRepository.deleteTask(id: event.task.id);
      }
    } on DioError catch (e) {
      if (e.error != SocketException) {
        final currentState = state as TaskListErrorState;
        emit(
          TaskListState.error(
            tasks: currentState.tasks,
            message: e.toString(),
          ),
        );
      }
    } catch (e) {
      final currentState = state as TaskListErrorState;
      emit(
        TaskListState.error(
          tasks: currentState.tasks,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onGetList(
      GetListEvent event, Emitter<TaskListState> emit) async {
    emit(
      const TaskListState.loading(),
    );
    try {
      final response = await _taskRepository.getList();
      emit(
        TaskListState.loaded(tasks: response),
      );
    } on DioError catch (e) {
      log(e.error.toString());
      final currentState = state as TaskListErrorState;
      if (e.error != SocketException) {
        emit(
          TaskListState.error(
            tasks: currentState.tasks,
            message: e.toString(),
          ),
        );
      }
    } catch (e) {
      final currentState = state as TaskListErrorState;
      emit(
        TaskListState.error(
          tasks: currentState.tasks,
          message: e.toString(),
        ),
      );
      //rethrow;
    }
  }
}
