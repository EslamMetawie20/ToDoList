import '../models/task_model.dart';

class TaskController {
  List<Task> tasks = [];
  DateTime? currentDate;

  void addTask(String title, String priority, DateTime deadline, [String? descrebtion]) {
    tasks.add(Task(title: title, descrebtion: descrebtion, priority: priority, deadline: deadline));
  }

  void toggleTaskStatus(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
  }
}
