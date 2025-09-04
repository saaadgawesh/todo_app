import 'package:flutter/material.dart';
import 'package:todo_app/appthem.dart';
import 'package:todo_app/view/setting/setting.dart';
import 'package:todo_app/view/tasks/bottomsheet.dart';
import 'package:todo_app/view/tasks/tasks.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int index1 = 0;

  List<Widget> tabs = [const Tasks(), const Setting()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[index1],

      ///***************************************floatingActionButton****////
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(
          side: BorderSide(width: 4, color: Appthem.white),
        ),
        focusColor: Appthem.primary,
        backgroundColor: Appthem.primary,

        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const Material(child: BottomSheetWidget()),
          );
        },
        child: const Icon(Icons.add),
      ),

      ////****************************************** bottomNavigationBar***/
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: index1,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Appthem.white,
        selectedItemColor: Appthem.white,
        backgroundColor: Appthem.primary,
        iconSize: 30,
        onTap: (index2) {
          setState(() {
            index1 = index2;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'القائمه'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_accessibility_outlined),
            label: 'الضبط',
          ),
        ],
      ),
    );
  }
}
