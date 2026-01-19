import 'package:custom_date_time/components/utils/calendar_utils.dart';
import 'package:flutter/material.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime yearMonth;
  final void Function(DateTime)? onPreviousMonth;
  final void Function(DateTime)? onNextMonth;
  final Color? backgroundColor;
  const CalendarHeader({
    super.key,
    required this.yearMonth,
    this.onPreviousMonth,
    this.onNextMonth,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              final previousMonth = DateTime(
                yearMonth.year,
                yearMonth.month - 1,
                1,
              );
              onPreviousMonth?.call(previousMonth);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
          ),
          Expanded(
            child: Center(
              child: Text(
                yearMonth.monthAndYear,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              final nextMonth = DateTime(yearMonth.year, yearMonth.month + 1, 1);

              onNextMonth?.call(nextMonth);
            },
            icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
          ),
        ],
      ),
    );
  }
}