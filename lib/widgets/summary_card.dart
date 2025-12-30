import 'package:flutter/material.dart';

// Виджет для отображения статистики - (всего - готов - актив)

class SummaryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color bgColor;
  final Color textColor;
  const SummaryCard({
    super.key,
    required this.title,
    required this.bgColor,
    required this.textColor,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
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
      child: Column(
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: textColor,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle.toUpperCase(),
            style: TextStyle(
              color: textColor,
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
