import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/tasks_model.dart';
import 'package:todo_app/view/homeScreen.dart';
import 'package:todo_app/view/widget/appthem.dart';
import 'package:todo_app/viewmodel/shared/sharedpref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); //1.hive.init
  // Hive.deleteBoxFromDisk('task');
  Hive.registerAdapter<Task>(TaskAdapter()); //2.hive.adaptor

  //2.hive.adaptor
  await Hive.openBox<Task>('task'); //3.hive.openbox

  await Firebase.initializeApp();
  // ⬇️ استرجاع بيانات المستخدم المخزنة
  final userData = await UserPrefs.getUser();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        // ChangeNotifierProvider(create: (_) => tasks_provider()),
      ],
      child: MyApp(userData: userData),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Map<String, String?> userData;
  const MyApp({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    // ⬇️ لو لقيت اسم مستخدم → دخّل على HomeScreen

    return MaterialApp(
      home: const Homescreen(),
      debugShowCheckedModeBanner: false,

      theme: Appthem.lightthem,
      themeMode: ThemeMode.light,
    );
  }
}
