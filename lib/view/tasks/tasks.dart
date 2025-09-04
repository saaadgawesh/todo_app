import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/appthem.dart';
import 'package:todo_app/view/authentication/login.dart';
// ✨ استيراد صفحة اللوجن
import 'package:todo_app/view/tasks/taskitem.dart';
import 'package:todo_app/viewmodel/provider/tasks_provider.dart';
import 'package:todo_app/viewmodel/shared/sharedpref.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  bool isloaded = false;

  @override
  Widget build(BuildContext context) {
    final tasksprovider = Provider.of<tasks_provider>(context);
    final currentUser =
        Provider.of<UserProvider>(context, listen: false).currentUser;

    // ✨ لو المستخدم مش مسجل دخول → رجعه لصفحة اللوجن
    if (currentUser == null) {
      Future.microtask(() {
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Login()),
          );
        }
      });
      return const SizedBox.shrink(); // يرجع Widget فاضي لحد ما يحصل التنقل
    }

    final userId = currentUser.id;
    final username = currentUser.name;

    if (isloaded == true) {
      tasksprovider.gettasksfilteration(userId);
    }

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.14,
          decoration: const BoxDecoration(color: Appthem.primary),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'welcome, $username',
                  style: const TextStyle(
                    color: Appthem.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const CircleAvatar(backgroundColor: Appthem.white, radius: 35),
              ],
            ),
          ),
        ),

        EasyInfiniteDateTimeLine(
          onDateChange: (selectedDate) {
            tasksprovider.changedate(selectedDate);
            tasksprovider.gettasksfilteration(userId);
          },

          activeColor: Appthem.primary,
          showTimelineHeader: false,
          firstDate: DateTime.now().subtract(const Duration(days: 30)),
          focusDate: tasksprovider.selecteddate,
          lastDate: DateTime.now().add(const Duration(days: 360)),
        ),
        Flexible(
          child: ListView.separated(
            itemCount: tasksprovider.taskat.length,
            separatorBuilder: (BuildContext context, int index) {
              return taskitem(tasksprovider.taskat[index]);
            },
            itemBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          ),
        ),
      ],
    );
  }
}
