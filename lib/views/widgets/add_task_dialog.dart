import 'package:flutter/material.dart';
import 'package:todolist/views/themes/theme.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(String, String, String?) onSave;
  const AddTaskDialog({super.key, required this.onSave});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? priority;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.offWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // 90% من عرض الشاشة
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.title, color: AppColors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.darkBlue, width: 2),
                  ),
                  labelStyle: TextStyle(color: AppColors.blue),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: priority,
                items: [
                  DropdownMenuItem(value: 'High', child: Text('High')),
                  DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                  DropdownMenuItem(value: 'Low', child: Text('Low')),
                ],
                onChanged: (value) {
                  setState(() {
                    priority = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.star, color: AppColors.darkBlue,),
                  labelText: 'Priority',
                  labelStyle: TextStyle(
                    color: AppColors.darkBlue,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.darkBlue, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(color: AppColors.darkBlue),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: 'Description (optional) ',
                  prefixIcon: Icon(Icons.description, color: AppColors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.darkBlue, width: 2),
                  ),
                  labelStyle: TextStyle(color: AppColors.blue),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: AppColors.blue),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isNotEmpty && priority != null) {
                        widget.onSave(
                          titleController.text,
                          priority!,
                          descriptionController.text,
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: AppColors.offWhite),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
