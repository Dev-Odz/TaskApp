import 'package:flutter/material.dart';

class TaskItemComponent extends StatefulWidget {
  const TaskItemComponent({
    super.key,
    required this.taskTitle,
    required this.id,
    required this.onDeleteTask,
  });

  final String? taskTitle;
  final int? id;
  final Function onDeleteTask;

  @override
  State<TaskItemComponent> createState() => _TaskItemComponentState();
}

class _TaskItemComponentState extends State<TaskItemComponent> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: Card(
              child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.taskTitle}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            decoration: isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    ],
                  )),
            ),
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        isDone
            ? InkWell(
                onTap: () {
                  setState(() {
                    isDone = false;
                  });
                },
                child: const Icon(Icons.check_box))
            : InkWell(
                onTap: () {
                  setState(() {
                    isDone = true;
                  });
                },
                child: const Icon(Icons.check_box_outline_blank_rounded),
              ),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {
            widget.onDeleteTask(widget.id);
          },
          child: const Icon(Icons.delete),
        ),
      ],
    );
  }
}
