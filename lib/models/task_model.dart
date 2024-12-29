class Task {
  String title;
  String? descrebtion;
  String priority;
  DateTime deadline;
  bool isCompleted;

  Task({
    required this.title,
    this.descrebtion,
    required this.priority,
    required this.deadline,
    this.isCompleted = false,
  });
}
