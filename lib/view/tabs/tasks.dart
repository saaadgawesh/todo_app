import 'dart:io';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/localstorage/applocal.dart';
import 'package:todo_app/model/tasks_model.dart';
import 'package:todo_app/view/onbourding/load_image_name/Loadimage-name.dart';
import 'package:todo_app/view/widget/appthem.dart';
import 'package:todo_app/view/widget/taskitem.dart';
import 'package:todo_app/viewmodel/shared/sharedpref.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  DateTime selectedDate = DateTime.now(); // التاريخ المختار

  @override
  Widget build(BuildContext context) {
    final currentUser =
        Provider.of<UserProvider>(context, listen: false).currentUser;

    // لو المستخدم مش مسجل دخول → رجعه لصفحة اللوجن
    if (currentUser == null) {
      Future.microtask(() {
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Loadimagename()),
          );
        }
      });
      return const SizedBox.shrink();
    }

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
        ),

        // 🟦 الـ Timeline
        EasyInfiniteDateTimeLine(
          onDateChange: (date) {
            setState(() {
              selectedDate = date; // تحديث التاريخ
            });
          },
          activeColor: Appthem.primary,
          showTimelineHeader: false,
          firstDate: DateTime.now().subtract(const Duration(days: 30)),
          lastDate: DateTime.now().add(const Duration(days: 360)),
          focusDate: selectedDate,
        ),

        // 🟦 عرض المهام
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: Hive.box<Task>('task').listenable(),
            builder: (BuildContext context, box, Widget? child) {
              try {
                // فلترة المهام حسب التاريخ
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
                      return TaskItem(task: tasks[index]);
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
    );
  }
}
