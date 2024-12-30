import 'package:flutter/material.dart';
import '../../controllers/task_controller.dart';
import 'SnackbarHelper.dart';
import 'add_task_dialog.dart';

class AddNewTaskButton extends StatelessWidget {
  final TaskController controller;

  AddNewTaskButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (scaffoldContext) {
        return FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddTaskDialog(
                  onSave: (String title, String priority, String? descrebtion) {
                    controller.addTask(title, priority, DateTime.now(), descrebtion);
                    SnackbarHelper.showMissionCreatedSnackbar(scaffoldContext, title);
                    Future.delayed(Duration(milliseconds: 500), () {
                      Navigator.pop(context);
                    });
                  },
                );
              },
            );
          },
          child: Icon(Icons.add),
        );
      },
    );
  }
}