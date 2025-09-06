import 'package:flutter/material.dart';
import 'package:todo_app/model/tasks_model.dart';
import 'package:todo_app/view/widget/appthem.dart';

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
        color: widget.task.iscomplete ? Appthem.green : Appthem.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const RotatedBox(
            quarterTurns: 3,
            child: Text(
              'todo',
              style: TextStyle(
                color: Appthem.white,
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Appthem.white,
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
                  style: const TextStyle(
                    color: Appthem.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 5),
                Text(
                  maxLines: 2,
                  widget.task.description,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Appthem.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
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
              onTap: () {},
              child: const Icon(Icons.check, color: Appthem.primary),
            ),
          ),
        ],
      ),
    );
  }
}
