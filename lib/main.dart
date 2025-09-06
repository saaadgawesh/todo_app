import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/model/tasks_model.dart';
import 'package:todo_app/view/onbourding/splashScreen/splashScrean.dart';
import 'package:todo_app/view/widget/appthem.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); //1.hive.init
  // Hive.deleteBoxFromDisk('task');
  Hive.registerAdapter<Task>(TaskAdapter()); //2.hive.adaptor

  //2.hive.adaptor
  await Hive.openBox<Task>('task'); //3.hive.openbox

  // await Firebase.initializeApp();
  // ⬇️ استرجاع بيانات المستخدم المخزنة

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ⬇️ لو لقيت اسم مستخدم → دخّل على HomeScreen

    return MaterialApp(
      home: const splashScrean(),
      debugShowCheckedModeBanner: false,

      theme: Appthem.lightthem,
      themeMode: ThemeMode.light,
    );
  }
}
