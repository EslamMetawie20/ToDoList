class Task {
  int? id;
  String title;
  String? descrebtion;
  String priority;
  DateTime deadline;
  bool isCompleted;

  Task({
    this.id,
    required this.title,
    this.descrebtion,
    required this.priority,
    required this.deadline,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': descrebtion,
      'priority': priority,
      'deadline': deadline.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      descrebtion: map['description'],
      priority: map['priority'],
      deadline: DateTime.parse(map['deadline']),
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
