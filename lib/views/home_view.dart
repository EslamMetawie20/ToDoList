import 'package:flutter/material.dart';
import 'package:todolist/views/themes/CustomAppBar.dart';
import 'package:todolist/views/widgets/add_task_dialog.dart';
import 'package:todolist/views/widgets/date_view.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TaskController controller = TaskController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: CustomAppBar(title: 'To Do List'),
        body: Column(
          children: [
            DateView(controller: controller),
            Divider(thickness: 2),
            Expanded(
              child: controller.tasks.isEmpty
                  ? Center(
                child: Text(
                  'There is no tasks',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
                  : ListView.builder(
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddTaskDialog(
                  onSave: (String title, String priority, String? descrebtion) {
                    setState(() {
                      controller.addTask(title, priority, DateTime.now(), descrebtion);
                    });
                  },
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),

      ),
    );
  }
}
