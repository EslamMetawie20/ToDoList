import 'package:flutter/material.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(String, String, String?) onSave;

  AddTaskDialog({required this.onSave});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? priority;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description (optional)'),
          ),
          SizedBox(height: 10),
          Text('Priority:'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => priority = 'High'),
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: Text('High'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => priority = 'Medium'),
                style: ElevatedButton.styleFrom(primary: Colors.orange),
                child: Text('Medium'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => priority = 'Low'),
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: Text('Low'),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (titleController.text.isNotEmpty && priority != null) {
              widget.onSave(titleController.text, priority!, descriptionController.text);
              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
