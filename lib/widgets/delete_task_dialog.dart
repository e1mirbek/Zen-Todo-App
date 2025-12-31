import 'package:flutter/material.dart';
import 'package:zen_todo/theme/colors.dart';
import 'package:zen_todo/widgets/app_button.dart';

class DeleteTaskDialog extends StatelessWidget {
  const DeleteTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      backgroundColor: AppColors.background,
      title: Text("Вы дествийтельно хотите удалить ? "),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20.0),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  title: "Нет",
                  backgroundColor: AppColors.bgField,
                  foregroundColor: AppColors.mainText,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: AppButton(
                  title: "Да",
                  backgroundColor: AppColors.red,
                  foregroundColor: AppColors.background,
                  onPressed: () => Navigator.pop(context, true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
