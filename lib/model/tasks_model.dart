import 'package:hive/hive.dart';

part 'tasks_model.g.dart';

@HiveType(typeId: 1)
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
