import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/appthem.dart';
import 'package:todo_app/model/tasks_model.dart';
import 'package:todo_app/view/tasks/defaultelevatedbotton.dart';
import 'package:todo_app/view/tasks/defaulttextfield.dart';
import 'package:todo_app/viewmodel/firebasefunctions.dart';
import 'package:todo_app/viewmodel/provider/tasks_provider.dart';
import 'package:todo_app/viewmodel/shared/sharedpref.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();
  DateFormat dateformate = DateFormat('dd/MM/yyyy');
  DateTime selecteddate = DateTime.now();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextStyle color = TextStyle(color: Appthem.primary);
    TextTheme theme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Form(
        key: formkey,
        child: Container(
          decoration: const BoxDecoration(
            color: Appthem.backgroundlight,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding:
              const EdgeInsets.all(15) +
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add New Task',
                style: theme.titleMedium?.copyWith(color: Appthem.primary),
              ),
              const SizedBox(height: 12),

              // حقل العنوان
              Defaulttextfield(
                controller: titleController,
                label: 'Enter Task Title',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'title can not be empty';
                  }
                },
              ),
              const SizedBox(height: 16),

              // حقل الوصف
              Defaulttextfield(
                controller: descriptionController,
                label: 'Enter Task Description',
                maxlines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'description can not be empty';
                  }
                },
              ),
              const SizedBox(height: 16),

              Text('Selected Date', style: color),
              const SizedBox(height: 10),

              // زر اختيار التاريخ (ثابت حالياً، قابل للتطوير)
              GestureDetector(
                onTap: () async {
                  DateTime? dateTime = await showDatePicker(
                    context: context,
                    initialDate: selecteddate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 360)),
                    barrierColor:
                        Appthem.backgroundlight, // لون خلفية الـ overlay
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Appthem.primary,
                            ),
                          ),
                          colorScheme: const ColorScheme.light(
                            primary: Appthem.primary, // لون الهيدر + الأزرار
                            onPrimary: Appthem.primary, // لون النص فوق الهيدر
                            onSurface: Appthem.primary, // لون النصوص العادية
                          ),
                          // dialogTheme: Colors.green, // خلفية الدايالوج
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (dateTime != null) {
                    setState(() {
                      selecteddate = dateTime;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Appthem.primary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    dateformate.format(selecteddate),
                    style: color,
                  ), // لاحقًا يمكن تغييره بالديناميكي
                ),
              ),
              const SizedBox(height: 20),

              // زر الدخول
              DefaultElevatedButton(
                label: 'Submit',

                onpress: () {
                  if (formkey.currentState!.validate()) {
                    addtask();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  addtask() {
    final userproviderid =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;

    Firebasefunctions.addtasktofirestore(
          TaskModel(
            title: titleController.text,
            description: descriptionController.text,
            date: selecteddate,
          ),
          userproviderid,
        )
        .then((value) {
          Navigator.of(context).pop();
          Provider.of<tasks_provider>(
            context,
            listen: false,
          ).gettasksfilteration(userproviderid);
        })
        .catchError((E) {
          print(E);
        });
  }
}
