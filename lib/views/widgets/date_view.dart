import 'package:flutter/material.dart';
import 'package:todolist/views/themes/theme.dart';
import '../../controllers/task_controller.dart';

class DateView extends StatefulWidget {
  final TaskController controller;

  DateView({required this.controller});

  @override
  _DateViewState createState() => _DateViewState();
}

class _DateViewState extends State<DateView> {
  late DateTime currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    widget.controller.currentDate = currentDate;
  }

  void moveToNextDay() {
    setState(() {
      currentDate = currentDate.add(Duration(days: 1));
      widget.controller.currentDate = currentDate;
      widget.controller.notifyListeners(); // إشعار عند تغيير التاريخ
    });
  }

  void moveToLastDay() {
    setState(() {
      currentDate = currentDate.subtract(Duration(days: 1));
      widget.controller.currentDate = currentDate;
      widget.controller.notifyListeners(); // إشعار عند تغيير التاريخ
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(Duration(days: 1));
    DateTime yesterday = today.subtract(Duration(days: 1));

    String displayDate;

    if (currentDate.year == today.year &&
        currentDate.month == today.month &&
        currentDate.day == today.day) {
      displayDate = 'Today';
    } else if (currentDate.year == tomorrow.year &&
        currentDate.month == tomorrow.month &&
        currentDate.day == tomorrow.day) {
      displayDate = 'Tomorrow';
    } else if (currentDate.year == yesterday.year &&
        currentDate.month == yesterday.month &&
        currentDate.day == yesterday.day) {
      displayDate = 'Yesterday';
    } else {
      displayDate =
      '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: moveToLastDay,
          color: AppColors.darkBlue,
        ),
        Text(
          displayDate,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue,
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: moveToNextDay,
          color: AppColors.darkBlue,
        ),
      ],
    );
  }
}
