import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/task_controller.dart';
import '../../views/themes/theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TaskController>(context);

    return AppBar(
      title: Row(
        children: [
          Icon(Icons.list_alt, color: Colors.white),
          SizedBox(width: 8),
          Text(title, style: TextStyle(color: Colors.white)),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          icon: Icon(Icons.sort, color: Colors.white),
          onSelected: (value) {
            controller.updateSortBy(value);
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'priority',
              child: Row(
                children: [
                  if (controller.sortBy == 'priority')
                    Icon(Icons.check, color: AppColors.darkBlue),
                  SizedBox(width: 8),
                  Text('Sort by Priority'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'added',
              child: Row(
                children: [
                  if (controller.sortBy == 'added')
                    Icon(Icons.check, color: AppColors.darkBlue),
                  SizedBox(width: 8),
                  Text('Sort by Added Order'),
                ],
              ),
            ),
          ],
        ),
      ],
      backgroundColor: AppColors.darkBlue,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
