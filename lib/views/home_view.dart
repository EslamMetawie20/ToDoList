import 'package:flutter/material.dart';
import 'package:todolist/views/themes/CustomAppBar.dart';
import 'package:todolist/views/widgets/date_view.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TaskController controller = TaskController();
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  DateTime? selectedDeadline;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: CustomAppBar(title: 'To Do List'),
        body: Column(
          children: [
            DateView(controller: controller), // عرض التاريخ تحت الـ AppBar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: taskTitleController,
                    decoration: InputDecoration(
                      labelText: 'Task Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: priorityController,
                    decoration: InputDecoration(
                      labelText: 'Priority (High/Medium/Low)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        selectedDeadline == null
                            ? 'Select Deadline'
                            : 'Deadline: ${selectedDeadline!.year}-${selectedDeadline!.month}-${selectedDeadline!.day}',
                      ),
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (newDate != null) {
                            setState(() {
                              selectedDeadline = newDate;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (taskTitleController.text.isNotEmpty &&
                          priorityController.text.isNotEmpty &&
                          selectedDeadline != null) {
                        setState(() {
                          controller.addTask(
                            taskTitleController.text,
                            priorityController.text,
                            selectedDeadline!,
                          );
                          taskTitleController.clear();
                          priorityController.clear();
                          selectedDeadline = null;
                        });
                      }
                    },
                    child: Text('Add Task'),
                  ),
                ],
              ),
            ),
            Divider(thickness: 2),
            Expanded(
              child: ListView.builder(
                itemCount: controller.tasks.length,
                itemBuilder: (context, index) {
                  final Task task = controller.tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(
                      'Priority: ${task.priority}\nDeadline: ${task.deadline.year}-${task.deadline.month}-${task.deadline.day}',
                    ),
                    trailing: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) {
                        setState(() {
                          controller.toggleTaskStatus(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
