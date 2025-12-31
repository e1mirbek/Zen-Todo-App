import 'package:flutter/material.dart';
import 'package:zen_todo/models/task.dart';

class TaskProvider extends ChangeNotifier {
  // 1.  приватный список - снаружи не даем доступ

  // хранилище задач

  final List<Task> _taskList = [];

  // 2. Геттер - (Чтобы  UI мог читать только список)

  List<Task> get tasks => _taskList;

  // ---- МЕТОДЫ ДЛЯ ВЫПОЛЕНИЙ ОПРЕДЕЛЕННЫХ ЗАДАЧ ------

  // 1. добавление задачи

  void addTask(String title) {
    _taskList.add(Task(id: DateTime.now().toString(), title: title));
    notifyListeners();
  }

  // 2. Изменить текущий задачи

  void updateTask(int index, String title) {
    _taskList[index] = Task(id: _taskList[index].id, title: title);
    notifyListeners();
  }

  // 3. Удалить задачу

  void deleteTask(int index) {
    _taskList.removeAt(index);
    notifyListeners();
  }
}
