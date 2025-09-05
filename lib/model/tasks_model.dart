// //

// import 'package:cloud_firestore/cloud_firestore.dart';

// class TaskModel {
//   String id;
//   String title;
//   String description;
//   DateTime date;
//   bool isDone;

//   TaskModel({
//     this.id='',
//     required this.title,
//     required this.description,
//     required this.date,
//     this.isDone = false,
//   });

//   // from JSON (Firestore) to Dart
//    TaskModel.fromJson(Map<String, dynamic> json):this(
//       title: json['title'],
//       description: json['description'],
//       date: (json['date'] as Timestamp).toDate(),
//       isDone: json['isdone'],
//     );

//   // from Dart to JSON (Firestore)

//   Map<String, dynamic> toJson()=> {

//       'title': title,
//       'description': description,
//       'date': Timestamp.fromDate(date),
//       'isdone': isDone,
//     };
// }
// //

import 'package:hive/hive.dart';

part 'tasks_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final bool iscomplete;

  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.iscomplete,
  });
}
