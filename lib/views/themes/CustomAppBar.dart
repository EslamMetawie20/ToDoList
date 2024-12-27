import 'package:flutter/material.dart';
import 'package:todolist/views/themes/theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/pic.webp'),
            radius: 16,
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: AppColors.darkBlue,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
