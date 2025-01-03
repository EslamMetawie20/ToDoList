import 'dart:math';
import 'package:flutter/material.dart';
import '../../controllers/task_controller.dart';
import 'SnackbarHelper.dart';
import 'add_task_dialog.dart';

class AddNewTaskButton extends StatefulWidget {
  final TaskController controller;

  AddNewTaskButton({required this.controller});

  @override
  State<AddNewTaskButton> createState() => _AddNewTaskButtonState();
}

class _AddNewTaskButtonState extends State<AddNewTaskButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (scaffoldContext) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: 1 + 0.1 * sin(_controller.value * 2 * pi),
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AddTaskDialog(
                        onSave: (String title, String priority, String? descrebtion) {
                          widget.controller.addTask(
                            title,
                            priority,
                            widget.controller.currentDate ?? DateTime.now(),
                            descrebtion,
                          );
                          SnackbarHelper.showMissionCreatedSnackbar(
                              scaffoldContext, title);
                          Future.delayed(Duration(milliseconds: 500), () {
                            Navigator.pop(context);
                          });
                        },
                      );
                    },
                  );
                },
                child: Icon(Icons.add),
              ),
            );
          },
        );
      },
    );
  }
}
