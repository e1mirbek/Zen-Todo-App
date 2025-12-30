import 'package:flutter/material.dart';

import '../theme/colors.dart';

// пустое состояние виджета - (когда нет задач)

class EmptyState extends StatelessWidget {
  final String mainText;
  final String secondaryText;
  const EmptyState({
    super.key,
    required this.mainText,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(),
      decoration: BoxDecoration(
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.cardBlueBg,
              child: Center(child: Icon(Icons.cloud_done_outlined)),
            ),
            const SizedBox(height: 20.0),
            Text(
              mainText,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.mainText,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              secondaryText,
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
