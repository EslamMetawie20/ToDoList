import 'package:flutter/material.dart';
import 'package:todolist/models/task_model.dart';


class TaskController extends ChangeNotifier {
  List<Task> tasks = [];
  DateTime? currentDate;

  void addTask(String title, String priority, DateTime deadline, [String? descrebtion]) {
    tasks.add(Task(title: title, descrebtion: descrebtion, priority: priority, deadline: deadline));
    notifyListeners();
  }

  void toggleTaskStatus(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    notifyListeners();
  }
}
