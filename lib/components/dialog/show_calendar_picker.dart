import 'package:custom_date_time/components/utils/responsive.dart';
import 'package:flutter/material.dart';

import '../calendar_widget.dart';
import '../utils/calendar_data.dart';

Future<DateTime?> showCalendarPicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? initialStartDate,
  DateTime? initialEndDate,
  Color? backgroundColor,
  Color? backgroundHeaderColor,
  Offset? boxShadowOffset,
  DatePickerMode mode = DatePickerMode.single,
  BorderRadiusGeometry? borderRadius,
  BoxBorder? border,
  List<BoxShadow>? boxShadow,
  BoxConstraints? constraints,
  Widget? iconBack,
  Widget? iconNext,
  Widget? cancelSubmitWidget,
  TextStyle? textHeaderStyle,
  TextStyle? textWeekStyle,
  Color? contentTodayTextColor,
  Color? contentBasicTextColor,
  Color? contentSelectedDateColor,
  Color? boxShadowColor,
  double? contentFontSize,
  List<CalendarData>? calendarData,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          constraints:
              constraints ??
              BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 1.3),
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            border: border,
            boxShadow: [
              BoxShadow(
                color: boxShadowColor ?? Colors.black,
                offset: boxShadowOffset ?? const Offset(6, 6).r(context),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            child: mode.build(
              backgroundColor: backgroundColor,
              backgroundHeaderColor: backgroundHeaderColor,
              iconBack: iconBack,
              iconNext: iconNext,
              initialDate: initialDate,
              textHeaderStyle: textHeaderStyle,
              textWeekStyle: textWeekStyle,
              todayTextColor: contentTodayTextColor,
              basicTextColor: contentBasicTextColor,
              fontSize: contentFontSize,
              initialEndDate: initialEndDate,
              initialStartDate: initialStartDate,
              backgroundColorSelected: contentSelectedDateColor,
              cancelSubmitWidget: cancelSubmitWidget,
              calendarData: calendarData,
            ),
          ),
        ),
      );
    },
  );
}

class SingleSelectionCalendar extends StatefulWidget {
  final DateTime? initialDate;
  final Color? backgroundColor, backgroundHeaderColor, backgroundColorSelected;
  final Widget? iconBack, iconNext, cancelSubmitWidget;
  final TextStyle? textHeaderStyle;
  final TextStyle? textWeekStyle;
  final Color? todayTextColor, basicTextColor;
  final double? fontSize;

  const SingleSelectionCalendar({
    super.key,
    this.iconBack,
    this.iconNext,
    this.backgroundColor,
    this.backgroundHeaderColor,
    this.fontSize,
    this.textHeaderStyle,
    this.textWeekStyle,
    this.todayTextColor,
    this.basicTextColor,
    this.initialDate,
    this.backgroundColorSelected,
    this.cancelSubmitWidget,
  });

  @override
  State<SingleSelectionCalendar> createState() =>
      _SingleSelectionCalendarState();
}

class _SingleSelectionCalendarState extends State<SingleSelectionCalendar> {
  final dateNotifier = ValueNotifier<DateTime?>(null);
  final monthNotifier = ValueNotifier<DateTime>(DateTime.now());

  @override
  void dispose() {
    dateNotifier.dispose();
    monthNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([dateNotifier, monthNotifier]),
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            color:
                widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 16.r(context),
            children: [
              CalendarWidget.single(
                initialYearMonth: widget.initialDate,
                fontSize: widget.fontSize,
                textHeaderStyle: widget.textHeaderStyle,
                textWeekStyle: widget.textWeekStyle,
                todayTextColor: widget.todayTextColor,
                basicTextColor: widget.basicTextColor,
                backgroundColorSelected: widget.backgroundColorSelected,
                iconBack: widget.iconBack,
                iconNext: widget.iconNext,
                backgroundHeaderColor:
                    widget.backgroundHeaderColor ??
                    Theme.of(context).colorScheme.primary,
                selectedDate: dateNotifier.value,
                onDateSelected: (date) {
                  dateNotifier.value = date;
                },
                onMonthChanged: (date) {
                  monthNotifier.value = date;
                },
                disableSelection: (date) {
                  return date.month != monthNotifier.value.month ||
                      date.year != monthNotifier.value.year;
                },
              ),
              widget.cancelSubmitWidget ??
                  Row(
                    spacing: 8.r(context),
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "CANCEL",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontSize: 14.r(context)),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, dateNotifier.value);
                        },
                        child: Text(
                          "OK",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontSize: 14.r(context)),
                        ),
                      ),
                    ],
                  ),
            ],
          ),
        );
      },
    );
  }
}

class RangeSelectionCalendar extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Color? backgroundColor, backgroundHeaderColor, backgroundColorSelected;
  final Widget? iconBack, iconNext, cancelSubmitWidget;
  final TextStyle? textHeaderStyle;
  final TextStyle? textWeekStyle;
  final Color? todayTextColor, basicTextColor;
  final double? fontSize;
  final List<CalendarData>? calendarData;

  const RangeSelectionCalendar({
    super.key,
    this.initialDate,
    this.initialStartDate,
    this.initialEndDate,
    this.backgroundColor,
    this.backgroundHeaderColor,
    this.iconBack,
    this.iconNext,
    this.fontSize,
    this.textHeaderStyle,
    this.textWeekStyle,
    this.todayTextColor,
    this.basicTextColor,
    this.backgroundColorSelected,
    this.cancelSubmitWidget,
    this.calendarData,
  });

  @override
  State<RangeSelectionCalendar> createState() => _RangeSelectionCalendarState();
}

class _RangeSelectionCalendarState extends State<RangeSelectionCalendar> {
  final startDateNotifier = ValueNotifier<DateTime?>(null);
  final endDateNotifier = ValueNotifier<DateTime?>(null);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([startDateNotifier, endDateNotifier]),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color:
                widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 16.r(context),
            children: [
              CalendarWidget.range(
                fontSize: widget.fontSize,
                textHeaderStyle: widget.textHeaderStyle,
                textWeekStyle: widget.textWeekStyle,
                todayTextColor: widget.todayTextColor,
                basicTextColor: widget.basicTextColor,
                backgroundColorSelected: widget.backgroundColorSelected,
                initialYearMonth: widget.initialDate,
                iconBack: widget.iconBack,
                iconNext: widget.iconNext,
                backgroundHeaderColor: widget.backgroundHeaderColor,
                selectedStartDate: startDateNotifier.value,
                selectedEndDate: endDateNotifier.value,
                onStartDateSelected: (date) {
                  startDateNotifier.value = date;
                },
                onEndDateSelected: (date) {
                  endDateNotifier.value = date;
                },
                calendarData: widget.calendarData,
              ),
              widget.cancelSubmitWidget ??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "CANCEL",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontSize: 14.r(context)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, [
                            startDateNotifier.value,
                            endDateNotifier.value,
                          ]);
                        },
                        child: Text("OK", style: Theme.of(context).textTheme.bodyMedium!
                            .copyWith(fontSize: 14.r(context)),
                        ),
                      ),
                    ],
                  ),
            ],
          ),
        );
      },
    );
  }
}

enum DatePickerMode { single, range }

extension DatePickerModeExtension on DatePickerMode {
  Widget build({
    Color? backgroundColor,
    Color? backgroundHeaderColor,
    Widget? iconBack,
    Widget? iconNext,
    DateTime? initialDate,
    DateTime? initialStartDate,
    DateTime? initialEndDate,
    TextStyle? textHeaderStyle,
    TextStyle? textWeekStyle,
    Color? todayTextColor,
    basicTextColor,
    backgroundColorSelected,
    double? fontSize,
    Widget? cancelSubmitWidget,
    List<CalendarData>? calendarData,
  }) {
    switch (this) {
      case DatePickerMode.single:
        return SingleSelectionCalendar(
          backgroundColor: backgroundColor,
          backgroundHeaderColor: backgroundHeaderColor,
          backgroundColorSelected: backgroundColorSelected,
          fontSize: fontSize,
          iconBack: iconBack,
          iconNext: iconNext,
          textHeaderStyle: textHeaderStyle,
          textWeekStyle: textWeekStyle,
          todayTextColor: todayTextColor,
          basicTextColor: basicTextColor,
          initialDate: initialDate,
          cancelSubmitWidget: cancelSubmitWidget,
        );
      case DatePickerMode.range:
        return RangeSelectionCalendar(
          backgroundColor: backgroundColor,
          backgroundHeaderColor: backgroundHeaderColor,
          backgroundColorSelected: backgroundColorSelected,
          fontSize: fontSize,
          iconBack: iconBack,
          iconNext: iconNext,
          textHeaderStyle: textHeaderStyle,
          textWeekStyle: textWeekStyle,
          todayTextColor: todayTextColor,
          basicTextColor: basicTextColor,
          initialDate: initialDate,
          cancelSubmitWidget: cancelSubmitWidget,
          initialStartDate: initialStartDate,
          initialEndDate: initialEndDate,
          calendarData: calendarData,
        );
    }
  }
}
