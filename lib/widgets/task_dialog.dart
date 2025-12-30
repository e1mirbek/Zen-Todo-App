import 'package:flutter/material.dart';
import 'package:zen_todo/theme/colors.dart';
import 'package:zen_todo/widgets/app_button.dart';

class TaskDialog extends StatefulWidget {
  final String? initialText;
  const TaskDialog({super.key, this.initialText});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  late final TextEditingController _taskController;

  // проверка если не null то рекдатируем задачу
  bool get isEditing => widget.initialText != null;

  @override
  void initState() {
    super.initState();
    // Если текст передали — вставляем его, если нет пусто
    _taskController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    super.dispose();
    _taskController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      backgroundColor: AppColors.background,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isEditing ? "Изменить" : "Новая задача",
            style: TextStyle(
              fontSize: 25.0,
              color: AppColors.mainText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            isEditing
                ? "Редактируйте прмяо сейчас"
                : "Что вы планируете сделать сегодня?",
            style: TextStyle(
              color: AppColors.secondaryText,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            minLines: 5,
            maxLines: 6,
            controller: _taskController,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.bgField,
              hintText: "Введите задачу...",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.bgField, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: AppColors.cardBlueText,
                  width: 2.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  title: "Отмена",
                  backgroundColor: AppColors.bgField,
                  foregroundColor: AppColors.mainText,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: AppButton(
                  title: isEditing ? "Изменить" : "Добавить",
                  backgroundColor: AppColors.primaryPurple,
                  foregroundColor: AppColors.background,
                  // ГЛАВНОЕ ИЗМЕНЕНИЕ:
                  // Мы не вызываем addTask(). Мы возвращаем текст тому, кто открыл диалог.
                  onPressed: () => Navigator.pop(context, _taskController.text),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
