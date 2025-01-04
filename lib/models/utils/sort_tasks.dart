import '../task_model.dart';

List<Task> sortTasks(List<Task> tasks, String sortBy) {
  final sortedTasks = List<Task>.from(tasks);

  if (sortBy == 'priority') {
    const priorityOrder = {'High': 1, 'Medium': 2, 'Low': 3};
    sortedTasks.sort((a, b) {
      return (priorityOrder[a.priority] ?? 4).compareTo(priorityOrder[b.priority] ?? 4);
    });
  } else if (sortBy == 'added') {
    sortedTasks.sort((a, b) => a.id!.compareTo(b.id!));
  }

  return sortedTasks;
}
