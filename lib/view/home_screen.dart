import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/view/task_form.dart';

import '../controller/task_controller.dart';


class HomePage extends StatelessWidget {
  final TaskController controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Get.to(() => TaskFormPage()),
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.tasks.length,
          itemBuilder: (context, index) {
            final task = controller.tasks[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => controller.deleteTask(task),
              ),
              onTap: () => Get.to(() => TaskFormPage(task: task)),
            );
          },
        );
      }),
    );
  }
}
