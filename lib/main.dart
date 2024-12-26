import 'package:flutter/material.dart';
import 'package:todolist/views/themes/theme.dart';
import 'views/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.darkBlue,
        scaffoldBackgroundColor: AppColors.offWhite,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkBlue,
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: AppColors.blue),
          bodyText2: TextStyle(color: AppColors.lightBlue),
        ),
      ),
      home: HomeView(),
    );
  }
}
