import 'package:custom_date_time/components/utils/calendar_utils.dart';
import 'package:custom_date_time/components/utils/responsive.dart';
import 'package:flutter/material.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime yearMonth;
  final void Function(DateTime)? onPreviousMonth;
  final void Function(DateTime)? onNextMonth;
  final Color? backgroundColor;
  final Widget? iconBack, iconNext;
  final TextStyle? textStyle;
  const CalendarHeader({
    super.key,
    required this.yearMonth,
    this.onPreviousMonth,
    this.onNextMonth,
    this.backgroundColor,
    this.iconBack,
    this.iconNext,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20).r(context),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              final previousMonth = DateTime(
                yearMonth.year,
                yearMonth.month - 1,
                1,
              );
              onPreviousMonth?.call(previousMonth);
            },
            child: iconBack ?? Icon(Icons.arrow_back_ios_rounded, size: 20.r(context)),
          ),
          Expanded(
            child: Center(
              child: Text(
                yearMonth.monthAndYear,
                style: textStyle ?? Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16.r(context),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final nextMonth = DateTime(yearMonth.year, yearMonth.month + 1, 1);

              onNextMonth?.call(nextMonth);
            },
            child: iconNext ?? Icon(Icons.arrow_forward_ios_rounded, size: 20.r(context)),
          ),
        ],
      ),
    );
  }
}