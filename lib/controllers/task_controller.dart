import 'package:flutter/material.dart';
import 'package:todolist/models/task_model.dart';
import '../models/utils/database_helper.dart';

class TaskController extends ChangeNotifier {
  List<Task> tasks = [];
  DateTime? currentDate;
  String sortBy = 'priority';
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> fetchTasks() async {
    final taskMaps = await _dbHelper.fetchTasks();
    tasks = taskMaps.map((taskMap) => Task.fromMap(taskMap)).toList();
    _sortTasks();
    notifyListeners();
  }

  void updateSortBy(String newSortBy) {
    sortBy = newSortBy;
    _sortTasks();
    notifyListeners();
  }

  void _sortTasks() {
    if (sortBy == 'priority') {
      const priorityOrder = {'High': 1, 'Medium': 2, 'Low': 3};
      tasks.sort((a, b) {
        return (priorityOrder[a.priority] ?? 4).compareTo(priorityOrder[b.priority] ?? 4);
      });
    } else if (sortBy == 'added') {
      tasks.sort((a, b) => a.id!.compareTo(b.id!));
    }
  }

  void addTask(String title, String priority, DateTime deadline, [String? description]) {
    final task = Task(
      title: title,
      descrebtion: description,
      priority: priority,
      deadline: deadline,
      isCompleted: false,
    );
    tasks.add(task);
    _sortTasks();
    notifyListeners();
    _dbHelper.insertTask(task.toMap());
  }

  void toggleTaskStatus(int index) {
    final task = tasks[index];
    task.isCompleted = !task.isCompleted;
    notifyListeners();
    _dbHelper.updateTask(task.id!, task.toMap());
  }

  void deleteTask(int id) {
    tasks.removeWhere((task) => task.id == id);
    notifyListeners();
    _dbHelper.deleteTask(id);


  }
}
