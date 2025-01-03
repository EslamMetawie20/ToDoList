import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/controllers/task_controller.dart';
import 'package:todolist/views/themes/theme.dart';
import 'views/home_view.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
      ),
    );
  }
}