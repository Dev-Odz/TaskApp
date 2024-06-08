// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

enum TaskStatus {
  initial,
  loading,
  loaded,
  error,
  onTaskAdded,
  onTaskUpdated,
  onTaskDeleted
}

class TaskState {
  const TaskState({
    required this.taskList,
    required this.taskStatus,
  });

  final List<TaskModel> taskList;
  final TaskStatus taskStatus;

  static TaskState initial() {
    return TaskState(
      taskList: [TaskModel()],
      taskStatus: TaskStatus.initial,
    );
  }

  TaskState copyWith({
    List<TaskModel>? taskList,
    TaskStatus? taskStatus,
  }) {
    return TaskState(
      taskList: taskList ?? this.taskList,
      taskStatus: taskStatus ?? this.taskStatus,
    );
  }
}
