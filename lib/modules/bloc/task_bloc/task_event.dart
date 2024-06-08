part of 'task_bloc.dart';

class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetTaskListEvent extends TaskEvent {
  const GetTaskListEvent();
}

class AddTaskEvent extends TaskEvent {
  const AddTaskEvent({
    required this.title,
    required this.isDone,
  });

  final String title;
  final bool isDone;
}

class DeleteTaskEvent extends TaskEvent {
  const DeleteTaskEvent(
    this.id,
  );

  final int id;
}
