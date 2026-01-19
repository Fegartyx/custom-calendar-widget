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
  final List<CalendarData>? calendarData;
  final bool Function(DateTime)? disableSelection;

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
  });

  factory CalendarWidget.single({
    Key? key,
    DateTime? initialYearMonth,
    DateTime? selectedDate,
    void Function(DateTime)? onDateSelected,
    List<CalendarData>? calendarData,
    bool Function(DateTime)? disableSelection,
  }) {
    return CalendarWidget._(
      key: key,
      singleSelectionMode: true,
      initialYearMonth: initialYearMonth,
      selectedStartDate: selectedDate,
      onStartDateSelected: onDateSelected,
      calendarData: calendarData,
      disableSelection: disableSelection,
    );
  }

  factory CalendarWidget.range({
    Key? key,
    DateTime? initialYearMonth,
    DateTime? selectedStartDate,
    DateTime? selectedEndDate,
    void Function(DateTime)? onStartDateSelected,
    void Function(DateTime?)? onEndDateSelected,
    List<CalendarData>? calendarData,
    bool Function(DateTime)? disableSelection,
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
              yearMonth: yearMonth,
              onPreviousMonth: (date) {
                yearMonthNotifier.value = date;
              },
              onNextMonth: (date) {
                yearMonthNotifier.value = date;
              },
            ),
            CalendarContent(
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