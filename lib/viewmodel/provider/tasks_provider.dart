
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewmodel/firebasefunctions.dart';
import 'package:todo_app/model/tasks_model.dart';


class tasks_provider with ChangeNotifier {
  ThemeMode thememode = ThemeMode.dark;
  bool get isdark => thememode == ThemeMode.dark;
  @override
  void changemode(ThemeMode selectedmode) {
    thememode = selectedmode;
    notifyListeners();
  }

  String language = 'ar';
  bool get isarabic => language == 'ar';
  @override
  void changelanguage(String selectlanguage) {
    language = selectlanguage;
    notifyListeners();
  }
DateTime selecteddate=DateTime.now();
  @override
  void changedate(DateTime date) {
  selecteddate=date;
    notifyListeners();
  }
   List<TaskModel>taskat=[];
  Future<void> gettasksfilteration(String userid)async{
  List <TaskModel>alltasks=
  await Firebasefunctions.gettaskfromfirestore(
     userid
  );
 taskat=alltasks.where((task) =>
  task.date.day==selecteddate.day &&
  task.date.month==selecteddate.month &&
  task.date.year==selecteddate.year ,
  ).toList();
  notifyListeners();

}

}
