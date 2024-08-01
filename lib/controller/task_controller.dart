import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../model/task.dart';

class TaskController extends GetxController {
  var taskBox = Hive.box<Task>('tasks');

  var tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() {
    tasks.value = taskBox.values.toList();
  }

  void addTask(Task task) {
    taskBox.add(task);
    loadTasks();
  }

  void updateTask(Task task) {
    task.save();
    loadTasks();
  }

  void deleteTask(Task task) {
    task.delete();
    loadTasks();
  }

  List<Task> getSortedTasks(String sortBy) {
    List<Task> sortedTasks = tasks.toList();
    if (sortBy == 'priority') {
      sortedTasks.sort((a, b) => a.priority.compareTo(b.priority));
    } else if (sortBy == 'dueDate') {
      sortedTasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    } else {
      sortedTasks.sort((a, b) => a.key.compareTo(b.key));
    }
    return sortedTasks;
  }

  List<Task> searchTasks(String query) {
    return tasks.where((task) => task.title.contains(query)).toList();
  }
}
