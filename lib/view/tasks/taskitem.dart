import 'package:flutter/material.dart';
import 'package:todo_app/appthem.dart';
import 'package:todo_app/model/tasks_model.dart';

class taskitem extends StatefulWidget {
  taskitem(this.task, {super.key});
  TaskModel task;

  @override
  State<taskitem> createState() => _taskitemState();
}

class _taskitemState extends State<taskitem> {
  bool isdone = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: 130,
      decoration: BoxDecoration(
        color: isdone ? Appthem.green : Appthem.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            color: Appthem.backgrounddark,
            height: MediaQuery.of(context).size.height * 0.6,
            width: 4,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.task.title, // ✅ دلوقتي بياخد العنوان من الموديل
                  style: const TextStyle(color: Appthem.backgrounddark),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const Divider(thickness: 1, color: Appthem.primary),
                Text(
                  widget.task.description,
                  overflow: TextOverflow.ellipsis, // ✅ الوصف من الموديل
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
                  isdone = !isdone;
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
