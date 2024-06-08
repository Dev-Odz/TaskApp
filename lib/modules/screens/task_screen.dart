import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app_final/modules/components/task_item_component.dart';

import '../bloc/task_bloc/task_bloc.dart';
import '../model/task_model.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

late TaskBloc _taskBloc;
TextEditingController taskController = TextEditingController();

void onDeleteTask(value) {
  _taskBloc.add(DeleteTaskEvent(value));
}

class _TaskScreenState extends State<TaskScreen> {
  void getInitialData() {
    _taskBloc.add(const GetTaskListEvent());
  }

  @override
  void initState() {
    super.initState();
    _taskBloc = TaskBloc();
    _taskBloc.add(const TaskEvent());
    getInitialData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _taskBloc,
      child: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.taskStatus == TaskStatus.initial) {
            return const Text('Getting Tasklist');
          } else if (state.taskStatus == TaskStatus.loaded &&
              state.taskList.isEmpty) {
            return const EmptyTaskWidget();
          } else if (state.taskStatus == TaskStatus.loaded ||
              state.taskStatus == TaskStatus.onTaskAdded) {
            return taskListWidget(state.taskList, context);
          } else if (state.taskStatus == TaskStatus.onTaskDeleted) {
            if (state.taskList.isEmpty) {
              return const EmptyTaskWidget();
            } else {
              return taskListWidget(state.taskList, context);
            }
          } else {
            return const EmptyTaskWidget();
          }
        },
      ),
    );
  }
}

Widget taskListWidget(List<TaskModel> taskList, BuildContext context) {
  List<Widget> finalTaskList = [];

  for (var i = 0; i < taskList.length; i++) {
    finalTaskList.add(TaskItemComponent(
      onDeleteTask: (value) {
        onDeleteTask(value);
      },
      id: i,
      taskTitle: taskList[i].title,
    ));
  }

  return Container(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...finalTaskList,
        const SizedBox(
          height: 24,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: floatinActionButtonAddTask(context),
        )
      ],
    ),
  );
}

class EmptyTaskWidget extends StatelessWidget {
  const EmptyTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No Task available',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          floatinActionButtonAddTask(context)
        ],
      ),
    );
  }
}

Widget floatinActionButtonAddTask(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(16),
              height: 250,
              width: 500,
              child: Container(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: taskController,
                              decoration: const InputDecoration(
                                hintText: 'Input your task',
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _taskBloc.add(
                                      AddTaskEvent(
                                          title: taskController.text,
                                          isDone: false),
                                    );

                                    Navigator.pop(context);

                                    taskController.clear();
                                  },
                                  child: const Text('Submit'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
    tooltip: 'Add Task',
    child: const Icon(Icons.add),
  );
}
