import '../models/task_model.dart';

class TaskController {
  List<Task> tasks = [];
  DateTime? currentDate; // متغير لتخزين التاريخ الحالي

  void addTask(String title, String priority, DateTime deadline) {
    tasks.add(Task(title: title, priority: priority, deadline: deadline));
  }

  void toggleTaskStatus(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
  }
}
