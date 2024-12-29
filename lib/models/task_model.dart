class Task {
  String title;
  String priority;
  DateTime deadline;
  bool isCompleted;

  Task({
    required this.title,
    required this.priority,
    required this.deadline,
    this.isCompleted = false,
  });
}
