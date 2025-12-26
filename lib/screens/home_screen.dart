import 'package:flutter/material.dart';
import 'package:zen_todo/models/task.dart';
import 'package:zen_todo/theme/colors.dart';
import 'package:zen_todo/widgets/empty_state.dart';
import 'package:zen_todo/widgets/summary_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController taskController = TextEditingController();

  // метод добавления задачи
  void addTask({required String title}) {
    setState(() {
      taskList.add(
        Task(id: DateTime.now().toString(), title: title, isDone: false),
      );
      taskController.clear();
      back();
    });
  }

  // метод удаление задачи

  void removeTask({required int index}) {
    setState(() {
      taskList.removeAt(index);
    });
  }

  void back() {
    Navigator.pop(context);
  }

  // хранилище задач

  List<Task> taskList = [
    // Task(id: "1", title: "Hello World"),
    // Task(id: "1", title: "Hello World"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
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
                            "${taskList.length} осталось",
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
                      title: "${taskList.length}",
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
                      title: "${taskList.length}",
                      subtitle: "актив",
                      bgColor: AppColors.cardOrangeBg,
                      textColor: AppColors.cardOrangeText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              taskList.isEmpty
                  ? SizedBox(
                      height: 400.0,
                      child: EmptyState(
                        mainText: "Список пуст",
                        secondaryText:
                            "Нажмите на плюс, чтобы\n добавить новую задачу",
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: taskList.length,
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
                              title: Text(taskList[index].title),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      color: AppColors.cardBlueText,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => removeTask(index: index),
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
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: AppColors.background,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Новая задача",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: AppColors.mainText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Что вы планируете сделать сегодня?",
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        minLines: 6,
                        maxLines: 6,
                        controller: taskController,
                        decoration: InputDecoration(
                          hintText: "Введите текст задачи...",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryPurple,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: AppColors
                                  .darkPurple, // Можно сделать потемнее/пожирнее
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                addTask(title: taskController.text),
                            child: Center(child: Text("Добавить")),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
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
