import 'package:custom_date_time/components/utils/calendar_data.dart';
import 'package:custom_date_time/components/utils/calendar_utils.dart';
import 'package:flutter/material.dart';

class CalendarContent extends StatelessWidget {
  final DateTime yearMonth;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final void Function(DateTime)? onStartDateSelected;
  final void Function(DateTime?)? onEndDateSelected;
  final bool singleSelectionMode;
  final List<CalendarData>? calendarData;
  final bool Function(DateTime)? disableSelection;
  final TextStyle? textWeekStyle;
  final Color? todayTextColor, basicTextColor,backgroundColor;
  final double? fontSize;

  const CalendarContent({
    super.key,
    required this.yearMonth,
    this.selectedStartDate,
    this.selectedEndDate,
    this.onStartDateSelected,
    this.onEndDateSelected,
    required this.singleSelectionMode,
    this.calendarData,
    this.disableSelection,
    this.textWeekStyle,
    this.todayTextColor,
    this.basicTextColor,
    this.fontSize,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final dates = yearMonth.getDaysOfMonth;
    final weeks = dates.chunkDates(7);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        spacing: 10,
        children: [
          CalendarDayOfWeek(textStyle: textWeekStyle,),
          ...weeks.map((week) {
            return Row(
              children:
                  week.map((date) {
                    return CalendarDateItem(
                      backgroundColor: backgroundColor,
                      todayText: todayTextColor,
                      basicText: basicTextColor,
                      fontSize: fontSize,
                      date: date,
                      yearMonth: yearMonth,
                      selectedStartDate: selectedStartDate,
                      selectedEndDate: selectedEndDate,
                      onStartDateSelected: onStartDateSelected,
                      onEndDateSelected: onEndDateSelected,
                      singleSelectionMode: singleSelectionMode,
                      calendarData: calendarData,
                      disableSelection: disableSelection,
                    );
                  }).toList(),
            );
          }),
        ],
      ),
    );
  }
}

class CalendarDayOfWeek extends StatefulWidget {
  final TextStyle? textStyle;

  const CalendarDayOfWeek({super.key, this.textStyle});

  @override
  State<CalendarDayOfWeek> createState() => _CalendarDayOfWeekState();
}

class _CalendarDayOfWeekState extends State<CalendarDayOfWeek> {
  final daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          daysOfWeek.map((day) {
            return Expanded(
              child: Text(
                day,
                textAlign: TextAlign.center,
                style:
                    widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }).toList(),
    );
  }
}

class CalendarDateItem extends StatefulWidget {
  final DateTime yearMonth, date;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final void Function(DateTime)? onStartDateSelected;
  final void Function(DateTime?)? onEndDateSelected;
  final bool singleSelectionMode;
  final List<CalendarData>? calendarData;
  final bool Function(DateTime)? disableSelection;
  final Color? todayText, basicText, backgroundColor;
  final double? fontSize;

  const CalendarDateItem({
    super.key,
    required this.yearMonth,
    required this.date,
    this.selectedStartDate,
    this.selectedEndDate,
    this.onStartDateSelected,
    this.onEndDateSelected,
    required this.singleSelectionMode,
    this.calendarData,
    this.disableSelection,
    this.todayText,
    this.basicText,
    this.fontSize,
    this.backgroundColor,
  });

  @override
  State<CalendarDateItem> createState() => _CalendarDateItemState();
}

class _CalendarDateItemState extends State<CalendarDateItem> {
  bool get disableSelection =>
      widget.disableSelection?.call(widget.date) ?? false;

  bool get isToday => widget.date.isSameDate(DateTime.now());

  bool get isCurrentVisibleMonth => widget.date.isSameMonth(widget.yearMonth);

  bool get isStartdate => widget.date.isSameDate(widget.selectedStartDate);

  bool get isEndDate => widget.date.isSameDate(widget.selectedEndDate);

  bool get isInRange =>
      widget.date.isBetween(widget.selectedStartDate, widget.selectedEndDate);

  bool get completeSelectedDate =>
      widget.selectedStartDate != null && widget.selectedEndDate != null;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (disableSelection) return;

          /// single selection
          if (widget.singleSelectionMode) {
            widget.onStartDateSelected?.call(widget.date);
            return;
          }

          /// range selection
          if (widget.selectedStartDate == null) {
            widget.onStartDateSelected?.call(widget.date);
            return;
          }
          if (widget.selectedEndDate == null) {
            final isBeforeStart = widget.date.isBefore(
              widget.selectedStartDate!,
            );

            if (isStartdate || isBeforeStart) {
              widget.onStartDateSelected?.call(widget.date);
              return;
            }

            widget.onEndDateSelected?.call(widget.date);
          }
          if (completeSelectedDate) {
            widget.onStartDateSelected?.call(widget.date);
            widget.onEndDateSelected?.call(null);
          }
        },
        child: Container(
          color: Colors.transparent,
          child: AspectRatio(
            aspectRatio: 1,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  buildIndicator(context, backgroundColorValue: widget.backgroundColor),
                  buildDate(context, widget.todayText, widget.basicText,fontSize: widget.fontSize),
                  if (widget.calendarData != null &&
                      widget.calendarData?.isNotEmpty == true)
                    Positioned(
                      bottom: 4,
                      child: Text(
                        widget.calendarData
                                ?.getCalendarData(widget.date)
                                ?.info ??
                            '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(BuildContext context, {Color? backgroundColorValue}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final backgroundColor = backgroundColorValue ?? Colors.blueGrey;
        final sizeRatio = 0.9;
        final size = constraints.maxHeight * sizeRatio;
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return SizedBox(
          width: maxWidth,
          height: maxHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (completeSelectedDate && isStartdate)
                Positioned(
                  right: 0,
                  child: Container(
                    width: maxWidth / 2,
                    height: size,
                    decoration: BoxDecoration(color: backgroundColor),
                  ),
                ),
              if (isInRange)
                Container(
                  width: maxWidth,
                  height: size,
                  decoration: BoxDecoration(color: backgroundColor),
                ),
              if (completeSelectedDate && isEndDate)
                Positioned(
                  left: 0,
                  child: Container(
                    width: maxWidth / 2,
                    height: size,
                    decoration: BoxDecoration(color: backgroundColor),
                  ),
                ),

              if (isStartdate || isEndDate) ...[
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: backgroundColor,
                  ),
                ),
                Container(
                  width: size - 6,
                  height: size - 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget buildDate(BuildContext context, Color? todayText, Color? basicText, {double? fontSize = 14}) {
    return Opacity(
      opacity: isCurrentVisibleMonth && !disableSelection ? 1 : 0.3,
      child: Text(
        '${widget.date.day}',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: fontSize,
          color: isToday ? todayText ?? Colors.lightBlue : basicText ?? Colors.black,
          fontWeight:
              isCurrentVisibleMonth ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
