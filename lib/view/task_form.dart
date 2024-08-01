import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/task_controller.dart';
import '../model/task.dart';


class TaskFormPage extends StatefulWidget {
  final Task? task;

  TaskFormPage({this.task});

  @override
  State<TaskFormPage> createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final TaskController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.task?.title ?? '');
    final descriptionController = TextEditingController(text: widget.task?.description ?? '');
    final priorityController = TextEditingController(text: widget.task?.priority.toString() ?? '1');
    final dueDateController = TextEditingController(text: widget.task?.dueDate.toString() ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final newTask = Task(
                title: titleController.text,
                description: descriptionController.text,
                priority: int.parse(priorityController.text),
                dueDate: _parseDate(dueDateController.text),
              );

              if (widget.task == null) {
                controller.addTask(newTask);
              } else {
                widget.task!
                  ..title = newTask.title
                  ..description = newTask.description
                  ..priority = newTask.priority
                  ..dueDate = newTask.dueDate;
                controller.updateTask(widget.task!);
              }
              Get.back();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: priorityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Priority'),
            ),
            TextField(
              controller: dueDateController,
              decoration: InputDecoration(
                labelText: 'Due Date',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (selectedDate != null) {
                      dueDateController.text = DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate);
                    }
                  },
                ),
              ),
              keyboardType: TextInputType.datetime,
            ),
          ],
        ),
      ),
    );
  }
  DateTime _parseDate(String dateString) {
    try {
      // Example of parsing a date in the format 'yyyy-MM-dd'
      final DateFormat format = DateFormat('yyyy-MM-dd');
      return format.parse(dateString);
    } catch (e) {
      // Handle parse error
      throw FormatException('Invalid date format');
    }
  }
}
