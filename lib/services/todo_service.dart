import 'package:flutter_hive_db/models/models.dart';
import 'package:hive/hive.dart';

class TodoService {
  late Box<Task> _tasksBox;

  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasksBox = await Hive.openBox<Task>('tasks');

    await _tasksBox.clear();

    await _tasksBox
        .add(Task('testUser1', 'testTask1', 'testDescription1', false));
    await _tasksBox
        .add(Task('flutter1', 'testTask1', 'testDescription1', false));
  }

  List<Task> getTask(final String userName) {
    final tasks = _tasksBox.values.where((element) => element.user == userName);
    return tasks.toList();
  }

  // Add Task
  void addTask(
      final String task, final String userName, final String description) {
    _tasksBox.add(Task(userName, task, description, false));
  }

  // REMOVE TASK
  void removeTask(final String task, final String userName) async {
    final taskRemove = _tasksBox.values.firstWhere(
        (element) => element.task == task && element.user == userName);
    await taskRemove.delete();
  }

  // UPDATE TASK
  void updateTask(
      final String task, final String userName, final String description,
      {final bool? completed}) async {
    final taskUpdate = _tasksBox.values.firstWhere(
        (element) => element.task == task && element.user == userName);
    final index = taskUpdate.key as int;
    await _tasksBox.put(index,
        Task(userName, task, description, completed ?? taskUpdate.completed));
  }
}
