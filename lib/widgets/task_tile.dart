import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zen_todo/provider/task_provider.dart';
import 'package:zen_todo/theme/colors.dart';
import 'package:zen_todo/widgets/task_dialog.dart';

import 'delete_task_dialog.dart';

class TaskTile extends StatelessWidget {
  final int index;
  const TaskTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final task = context.watch<TaskProvider>().tasks[index];
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 9,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: IconButton(
          onPressed: () => context.read<TaskProvider>().toggleTaskStatus(index),
          icon: Icon(task.isDone ? Icons.check_circle : Icons.circle_outlined),
          color: task.isDone
              ? AppColors.cardGreenText
              : AppColors.secondaryText,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            color: task.isDone ? AppColors.secondaryText : AppColors.mainText,
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // редактирование
            IconButton(
              // 1. вызов метода с помощью context.read
              onPressed: () async {
                // 2. первым делом при редоктирований берем текущий список задачи
                final currentIndex = task.title[index];

                final String? newTitle = await showDialog(
                  context: context,
                  builder: (context) => TaskDialog(initialText: currentIndex),
                );
                if (newTitle != null) {
                  context.read<TaskProvider>().updateTask(index, newTitle);
                }
              },
              icon: Icon(Icons.edit_outlined, color: AppColors.cardBlueText),
            ),
            // удаление
            IconButton(
              // вызов метода context.read
              onPressed: () async {
                final deleteTask = await showDialog(
                  context: context,
                  builder: (context) => const DeleteTaskDialog(),
                );
                if (deleteTask != null) {
                  context.read<TaskProvider>().deleteTask(index);
                }
              },
              icon: Icon(
                Icons.delete_outline,
                color: AppColors.red,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
