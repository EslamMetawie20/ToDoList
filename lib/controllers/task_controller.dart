import 'package:flutter/material.dart';
import 'package:todolist/models/task_model.dart';

class TaskController extends ChangeNotifier {
  List<Task> tasks = [];
  DateTime? currentDate;

  void addTask(String title, String priority, DateTime deadline, [String? descrebtion]) {
    if (currentDate != null) {
      // إنشاء تاريخ جديد يحتوي فقط على اليوم والشهر والسنة من التاريخ الحالي
      final taskDeadline = DateTime(
        currentDate!.year,
        currentDate!.month,
        currentDate!.day,
      );

      tasks.add(Task(
        title: title,
        descrebtion: descrebtion,
        priority: priority,
        deadline: taskDeadline,
      ));

      notifyListeners();
    }
  }

  void toggleTaskStatus(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    notifyListeners();
  }
}