import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/appthem.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/view/HomeScreen.dart';
import 'package:todo_app/view/authentication/login.dart';
import 'package:todo_app/viewmodel/provider/tasks_provider.dart';
import 'package:todo_app/viewmodel/shared/sharedpref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // ⬇️ استرجاع بيانات المستخدم المخزنة
  final userData = await UserPrefs.getUser();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => tasks_provider()),
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
    Widget startScreen;
    if (userData["name"] != null && userData["name"]!.isNotEmpty) {
      // حدث الـ Provider باليوزر
      final user = UserModel(
        id: userData["id"] ?? "",
        name: userData["name"] ?? "",
        email: userData["email"] ?? "",
      );
      Provider.of<UserProvider>(context, listen: false).setUser(user);

      startScreen = const Homescreen();
    } else {
      startScreen = const Login();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startScreen,
      theme: Appthem.lightthem,
      themeMode: ThemeMode.light,
    );
  }
}
