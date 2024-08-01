import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo_list_app/services/notification_services.dart';
import 'package:todo_list_app/view/home_screen.dart';

import 'model/task.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

  final notificationService = NotificationService();
  await notificationService.init();

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDoList App',
      home: HomePage(),
    );
  }
}
