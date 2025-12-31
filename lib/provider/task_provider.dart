import 'package:flutter/material.dart';
import 'package:zen_todo/models/task.dart';

class TaskProvider extends ChangeNotifier {
  // хранилище задач

  final List<Task> _taskList = [];

  // 2. Геттер - (Чтобы  UI мог читать только список)

  List<Task> get tasks => _taskList;

  // всего
  int get totalCount => _taskList.length;

  // Готов - (где сколько задач == isDone - (true) )
  int get doneCount => _taskList.where((task) => task.isDone).length;

  // АКТИВНО - (ВСЕГО - ГОТОВО)
  int get activeCount => totalCount - doneCount;

  // ---- МЕТОДЫ ДЛЯ ВЫПОЛЕНИЙ ОПРЕДЕЛЕННЫХ ЗАДАЧ ------

  // add
  void addTask(String title) {
    _taskList.add(Task(id: DateTime.now().toString(), title: title));
    notifyListeners();
  }

  // update
  void updateTask(int index, String title) {
    _taskList[index] = Task(id: _taskList[index].id, title: title);
    notifyListeners();
  }

  // delete
  void deleteTask(int index) {
    _taskList.removeAt(index);
    notifyListeners();
  }

  // метод переключение статуса

  void toggleTaskStatus(int index) {
    final task = _taskList[index];
    _taskList[index] = Task(
      id: task.id,
      title: task.title,
      isDone: !task.isDone, // меняется на противооложный либо false либо true
    );
    notifyListeners();
  }
}
