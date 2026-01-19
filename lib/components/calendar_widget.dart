import 'package:custom_date_time/components/utils/calendar_data.dart';
import 'package:custom_date_time/components/widgets/calendar_content.dart';
import 'package:custom_date_time/components/widgets/calendar_header.dart';
import 'package:flutter/material.dart';

class CalendarWidget extends StatefulWidget {
  final bool singleSelectionMode;
  final DateTime? initialYearMonth;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final void Function(DateTime)? onStartDateSelected;
  final void Function(DateTime?)? onEndDateSelected;
  final void Function(DateTime)? onMonthChanged;
  final List<CalendarData>? calendarData;
  final bool Function(DateTime)? disableSelection;
  final Color? backgroundHeaderColor;
  final Widget? iconBack, iconNext;
  final TextStyle? textHeaderStyle;
  final TextStyle? textWeekStyle;
  final Color? todayTextColor, basicTextColor, backgroundColorSelected;
  final double? fontSize;

  const CalendarWidget._({
    super.key,
    this.singleSelectionMode = false,
    this.initialYearMonth,
    this.selectedStartDate,
    this.selectedEndDate,
    this.onStartDateSelected,
    this.onEndDateSelected,
    this.calendarData,
    this.disableSelection,
    this.onMonthChanged,
    this.backgroundHeaderColor,
    this.iconBack,
    this.iconNext,
    this.textHeaderStyle,
    this.textWeekStyle,
    this.todayTextColor,
    this.basicTextColor,
    this.fontSize,
    this.backgroundColorSelected,
  });

  factory CalendarWidget.single({
    Key? key,
    DateTime? initialYearMonth,
    DateTime? selectedDate,
    void Function(DateTime)? onDateSelected,
    void Function(DateTime)? onMonthChanged,
    List<CalendarData>? calendarData,
    bool Function(DateTime)? disableSelection,
    Color? backgroundHeaderColor,
    Widget? iconBack,
    Widget? iconNext,
    TextStyle? textHeaderStyle,
    TextStyle? textWeekStyle,
    Color? todayTextColor,
    Color? basicTextColor,
    double? fontSize,
    Color? backgroundColorSelected,
  }) {
    return CalendarWidget._(
      key: key,
      singleSelectionMode: true,
      initialYearMonth: initialYearMonth,
      selectedStartDate: selectedDate,
      onStartDateSelected: onDateSelected,
      calendarData: calendarData,
      disableSelection: disableSelection,
      onMonthChanged: onMonthChanged,
      backgroundHeaderColor: backgroundHeaderColor,
      iconBack: iconBack,
      iconNext: iconNext,
      textHeaderStyle: textHeaderStyle,
      textWeekStyle: textWeekStyle,
      todayTextColor: todayTextColor,
      basicTextColor: basicTextColor,
      fontSize: fontSize,
      backgroundColorSelected: backgroundColorSelected,
    );
  }

  factory CalendarWidget.range({
    Key? key,
    DateTime? initialYearMonth,
    DateTime? selectedStartDate,
    DateTime? selectedEndDate,
    void Function(DateTime)? onStartDateSelected,
    void Function(DateTime?)? onEndDateSelected,
    void Function(DateTime)? onMonthChanged,
    List<CalendarData>? calendarData,
    bool Function(DateTime)? disableSelection,
    Color? backgroundHeaderColor,
    Widget? iconBack,
    Widget? iconNext,
    TextStyle? textHeaderStyle,
    TextStyle? textWeekStyle,
    Color? todayTextColor,
    Color? basicTextColor,
    double? fontSize,
    Color? backgroundColorSelected,
  }) {
    return CalendarWidget._(
      key: key,
      singleSelectionMode: false,
      initialYearMonth: initialYearMonth,
      selectedStartDate: selectedStartDate,
      selectedEndDate: selectedEndDate,
      onStartDateSelected: onStartDateSelected,
      onEndDateSelected: onEndDateSelected,
      calendarData: calendarData,
      disableSelection: disableSelection,
      onMonthChanged: onMonthChanged,
      backgroundHeaderColor: backgroundHeaderColor,
      iconBack: iconBack,
      iconNext: iconNext,
      textHeaderStyle: textHeaderStyle,
      textWeekStyle: textWeekStyle,
      todayTextColor: todayTextColor,
      basicTextColor: basicTextColor,
      fontSize: fontSize,
      backgroundColorSelected: backgroundColorSelected
    );
  }

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final yearMonthNotifier = ValueNotifier(DateTime.now());

  @override
  void initState() {
    if (widget.initialYearMonth != null) {
      yearMonthNotifier.value = widget.initialYearMonth!;
      widget.onMonthChanged?.call(yearMonthNotifier.value);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: yearMonthNotifier,
      builder: (context, yearMonth, child) {
        return Column(
          spacing: 15,
          children: [
            CalendarHeader(
              iconBack: widget.iconBack,
              iconNext: widget.iconNext,
              textStyle: widget.textHeaderStyle,
              backgroundColor: widget.backgroundHeaderColor,
              yearMonth: yearMonth,
              onPreviousMonth: (date) {
                yearMonthNotifier.value = date;
                widget.onMonthChanged?.call(date);
              },
              onNextMonth: (date) {
                yearMonthNotifier.value = date;
                widget.onMonthChanged?.call(date);
              },
            ),
            CalendarContent(
              backgroundColor: widget.backgroundColorSelected,
              fontSize: widget.fontSize,
              todayTextColor: widget.todayTextColor,
              basicTextColor: widget.basicTextColor,
              textWeekStyle: widget.textWeekStyle,
              yearMonth: yearMonth,
              selectedStartDate: widget.selectedStartDate,
              selectedEndDate: widget.selectedEndDate,
              onStartDateSelected: widget.onStartDateSelected,
              onEndDateSelected: widget.onEndDateSelected,
              singleSelectionMode: widget.singleSelectionMode,
              calendarData: widget.calendarData,
              disableSelection: widget.disableSelection,
            ),
          ],
        );
      },
    );
  }
}