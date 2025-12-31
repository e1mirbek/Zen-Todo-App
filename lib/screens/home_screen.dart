import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zen_todo/provider/task_provider.dart';
import 'package:zen_todo/theme/colors.dart';
import 'package:zen_todo/widgets/task_dialog.dart';
import 'package:zen_todo/widgets/empty_state.dart';
import 'package:zen_todo/widgets/summary_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Подключаемся к provider (Слушаем изменения)
    // 2. context.wath - обозначение (если в provider что то изменится то рисуем занаво)

    final provider = context.watch<TaskProvider>();

    // 3. Берем список из provider
    final tasks = provider.tasks;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "ZenTodo",
                  style: TextStyle(
                    color: AppColors.mainText,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      overflow: TextOverflow.ellipsis,
                      "Твои задачи",
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: AppColors.background,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 5.0,
                              backgroundColor: AppColors.darkPurple,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              "${tasks.length} осталось",
                              style: TextStyle(
                                color: AppColors.mainText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                Row(
                  children: [
                    Expanded(
                      child: SummaryCard(
                        title: "${tasks.length}",
                        subtitle: "всего",
                        bgColor: AppColors.cardBlueBg,
                        textColor: AppColors.cardBlueText,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: SummaryCard(
                        title: "0",
                        subtitle: "готово",
                        bgColor: AppColors.cardGreenBg,
                        textColor: AppColors.cardGreenText,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: SummaryCard(
                        title: "${tasks.length}",
                        subtitle: "актив",
                        bgColor: AppColors.cardOrangeBg,
                        textColor: AppColors.cardOrangeText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                tasks.isEmpty
                    ? SizedBox(
                        height: 400.0,
                        child: EmptyState(
                          mainText: "Список пуст",
                          secondaryText:
                              "Нажмите на плюс, чтобы\n добавить новую задачу",
                        ),
                      )
                    : ListView.builder(
                        physics:
                            NeverScrollableScrollPhysics(), // отключаем scroll
                        shrinkWrap:
                            true, // занять столько высоты, сколько нужно задач
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
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
                              title: Text(tasks[index].title),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // редактирование
                                  IconButton(
                                    // 1. вызов метода с помощью context.read
                                    onPressed: () async {
                                      // 2. первым делом при редоктирований берем текущий список задачи
                                      final currentIndex = tasks[index].title;

                                      final String? newTitle = await showDialog(
                                        context: context,
                                        builder: (context) => TaskDialog(
                                          initialText: currentIndex,
                                        ),
                                      );
                                      if (newTitle != null) {
                                        context.read<TaskProvider>().updateTask(
                                          index,
                                          newTitle,
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      color: AppColors.cardBlueText,
                                    ),
                                  ),
                                  // удаление
                                  IconButton(
                                    // вызов метода context.read
                                    onPressed: () => context
                                        .read<TaskProvider>()
                                        .deleteTask(index),
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
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () async {
            final result = await showDialog(
              context: context,
              builder: (context) => const TaskDialog(),
            );
            if (result != null) {
              context.read<TaskProvider>().addTask(result);
            }
          },
          backgroundColor: AppColors.primaryPurple,
          shape: const CircleBorder(),
          elevation: 0,
          // Иконка плюса
          child: const Icon(
            Icons.add,
            size: 40, // РАЗМЕР ИКОНКИ внутри круга
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
