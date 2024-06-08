import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_app_final/modules/model/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState.initial()) {
    on<TaskEvent>((event, emit) {});
    on<GetTaskListEvent>(_onGetTaskListEvent);
    on<AddTaskEvent>(_onAddTaskEvent);
    on<DeleteTaskEvent>(_onDeleteTaskEvent);
  }

  FutureOr<void> _onGetTaskListEvent(
      GetTaskListEvent event, Emitter<TaskState> emit) {
    try {
      emit(
        const TaskState(
          taskList: [],
          taskStatus: TaskStatus.loading,
        ),
      );

      emit(
        TaskState(
          taskList: state.taskList,
          taskStatus: TaskStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        const TaskState(
          taskList: [],
          taskStatus: TaskStatus.error,
        ),
      );
    }
  }

  FutureOr<void> _onAddTaskEvent(AddTaskEvent event, Emitter<TaskState> emit) {
    List<TaskModel> newTaskList = state.taskList.isEmpty ? [] : state.taskList;

    try {
      newTaskList.add(
        TaskModel(
          title: event.title,
          isDone: event.isDone,
        ),
      );

      emit(
        TaskState(
          taskList: newTaskList,
          taskStatus: TaskStatus.onTaskAdded,
        ),
      );
    } catch (e) {
      print(e);
      emit(
        const TaskState(
          taskList: [],
          taskStatus: TaskStatus.error,
        ),
      );
    }
  }

  FutureOr<void> _onDeleteTaskEvent(
      DeleteTaskEvent event, Emitter<TaskState> emit) {
    try {
      List<TaskModel> newTaskList =
          state.taskList.isEmpty ? [] : state.taskList;

      newTaskList.removeAt(event.id);

      emit(
        TaskState(
          taskList: newTaskList,
          taskStatus: TaskStatus.onTaskDeleted,
        ),
      );
    } catch (e) {
      emit(
        const TaskState(
          taskList: [],
          taskStatus: TaskStatus.error,
        ),
      );
    }
  }
}
