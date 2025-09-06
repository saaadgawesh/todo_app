import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'package:todo_app/localstorage/applocal.dart';

import 'package:todo_app/model/tasks_model.dart';
import 'package:todo_app/view/widget/appthem.dart';
import 'package:todo_app/view/widget/taskitem.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: EasyInfiniteDateTimeLine(
              onDateChange: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
              activeColor: Appthem.primary,
              showTimelineHeader: false,
              firstDate: DateTime.now().subtract(const Duration(days: 30)),
              lastDate: DateTime.now().add(const Duration(days: 360)),
              focusDate: selectedDate,

    return Column(
      children: [
        // 🟦 الهيدر (اسم + صورة)
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.14,
          decoration: const BoxDecoration(color: Appthem.primary),
          child: Padding(
            padding: EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                  future: Applocal.getdata(Applocal.imagekey),
                  builder: (context, snapshot) {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(File(snapshot.data!)),
                    );
                  },
                ),
                const SizedBox(width: 20),
                FutureBuilder(
                  future: Applocal.getdata(Applocal.namekey),
                  builder: (context, snapshot) {
                    return Text(
                      ' welcome ${snapshot.data}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ],

            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<Task>('task').listenable(),
              builder: (BuildContext context, box, Widget? child) {
                try {
                  final tasks =
                      box.values
                          .where(
                            (task) =>
                                task.date.year == selectedDate.year &&
                                task.date.month == selectedDate.month &&
                                task.date.day == selectedDate.day,
                          )
                          .toList();

                  if (tasks.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/1.png'),
                          const SizedBox(height: 30),
                          const Text('No tasks found for this day'),
                        ],
                      ),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        final task = tasks[index];

                        return Dismissible(
                          key: UniqueKey(),
                          // key: ValueKey(
                          //   // task.title + task.date.toIso8601String(),
                          // ),
                          onDismissed: (direction) {
                            setState(() {
                              tasks.removeAt(index); // ✅ اشيل العنصر من الليست
                            });

                            if (direction == DismissDirection.startToEnd) {
                              box.putAt(
                                index,
                                Task(
                                  title: task.title,
                                  description: task.description,
                                  date: task.date,
                                  iscomplete: true,

                                ),
                              );
                            } else {
                              box.deleteAt(index);
                            }
                          },
                          background: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Appthem.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'COMPLETE TASK',
                                  style: TextStyle(color: Appthem.white),
                                ),
                                Icon(Icons.check, color: Appthem.white),
                              ],
                            ),
                          ),
                          secondaryBackground: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Appthem.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'DELETE TASK',
                                  style: TextStyle(color: Appthem.white),
                                ),
                                Icon(Icons.delete_sharp, color: Appthem.white),
                              ],
                            ),
                          ),
                          child: TaskItem(task: task),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    );
                  }
                } catch (e, stackTrace) {
                  debugPrint("❌ Error in tasks list: $e");
                  debugPrint("StackTrace: $stackTrace");
                  return Center(
                    child: Text(
                      "Error loading tasks ❌",
                      style: TextStyle(color: Colors.red[700], fontSize: 18),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
