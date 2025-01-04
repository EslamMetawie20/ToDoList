import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/views/themes/CustomAppBar.dart';
import 'package:todolist/views/themes/theme.dart';
import 'package:todolist/views/widgets/AddNewTaskButton.dart';
import 'package:todolist/views/widgets/ShowTaskDialog.dart';
import 'package:todolist/views/widgets/date_view.dart';
import '../controllers/task_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    final controller = Provider.of<TaskController>(context, listen: false);
    controller.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'To Do List'),
      body: Column(
        children: [
          Consumer<TaskController>(
            builder: (context, controller, child) => DateView(controller: controller),
          ),
          Divider(),
          Expanded(
            child: Consumer<TaskController>(
              builder: (context, controller, child) {
                if (controller.currentDate == null) {
                  return Center(child: Text('Please select a date'));
                }

                final filteredTasks = controller.tasks.where((task) {
                  final taskDate = DateTime(
                    task.deadline.year,
                    task.deadline.month,
                    task.deadline.day,
                  );
                  final selectedDate = DateTime(
                    controller.currentDate!.year,
                    controller.currentDate!.month,
                    controller.currentDate!.day,
                  );
                  return taskDate.isAtSameMomentAs(selectedDate);
                }).toList();


                if (controller.sortBy == 'priority') {
                  const priorityOrder = {'High': 1, 'Medium': 2, 'Low': 3};
                  filteredTasks.sort((a, b) {
                    return (priorityOrder[a.priority] ?? 4)
                        .compareTo(priorityOrder[b.priority] ?? 4);
                  });
                } else if (controller.sortBy == 'added') {
                  filteredTasks.sort((a, b) => a.id!.compareTo(b.id!));
                }

                if (filteredTasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.task_outlined,
                          size: 64,
                          color: AppColors.blue.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No tasks for this day',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add a new task by clicking the + button',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.blue.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      final originalIndex = controller.tasks.indexOf(task);
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.darkBlue.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => ShowTaskDialog(task: task),
                            );
                          },
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                _PriorityBadge(priority: task.priority),
                                const SizedBox(width: 12),
                                Text(
                                  '${task.deadline.year}-${task.deadline.month.toString().padLeft(2, '0')}-${task.deadline.day.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    color: AppColors.blue,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Transform.scale(
                            scale: 1.2,
                            child: Checkbox(
                              value: task.isCompleted,
                              onChanged: (value) =>
                                  controller.toggleTaskStatus(originalIndex),
                              activeColor: AppColors.darkBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Consumer<TaskController>(
        builder: (context, controller, child) => AddNewTaskButton(controller: controller),
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final String priority;

  const _PriorityBadge({
    Key? key,
    required this.priority,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        'Priority: $priority',
        style: TextStyle(
          color: AppColors.darkBlue,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
