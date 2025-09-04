// 

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String title;
  String description;
  DateTime date;
  bool isDone;

  TaskModel({
    this.id='',
    required this.title,
    required this.description,
    required this.date,
    this.isDone = false,
  });

  // from JSON (Firestore) to Dart
   TaskModel.fromJson(Map<String, dynamic> json):this(
      title: json['title'],
      description: json['description'],
      date: (json['date'] as Timestamp).toDate(),
      isDone: json['isdone'],
    );
  

  // from Dart to JSON (Firestore)
 
  Map<String, dynamic> toJson()=> {
    
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(date),
      'isdone': isDone,
    };
}
// 


