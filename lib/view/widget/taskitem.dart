import 'package:flutter/material.dart';
import 'package:todo_app/view/widget/appthem.dart';
import 'package:todo_app/model/tasks_model.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: 130,
      decoration: BoxDecoration(
        color: isDone ? Appthem.green : Appthem.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Appthem.backgrounddark,
            height: double.infinity,
            width: 4,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.task.title,
                  style: const TextStyle(color: Appthem.backgrounddark),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const Divider(thickness: 1, color: Appthem.primary),
                Text(
                  widget.task.description,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Appthem.backgrounddark),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            height: 35,
            width: MediaQuery.of(context).size.width * 0.17,
            decoration: BoxDecoration(
              color: Appthem.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isDone = !isDone;
                });
              },
              child: const Icon(Icons.check, color: Appthem.primary),
            ),
          ),
        ],
      ),
    );
  }
}
