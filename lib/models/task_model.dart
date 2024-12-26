class Task {
  String title;
  String priority; // الأولوية
  DateTime deadline; // الموعد النهائي
  bool isCompleted;

  Task({
    required this.title,
    required this.priority,
    required this.deadline,
    this.isCompleted = false,
  });
}
