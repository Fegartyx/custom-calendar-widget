import 'package:custom_date_time/components/utils/calendar_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  /// returns a list of dates representing a full calendar grid for the given month and year of the date
  ///
  /// - The first element is guaranteed to be a Monday, which may fall in the previous month
  /// - The last element is guaranteed to be a Sunday, which may fall in the next month
  /// - All days of the target month are included
  /// - Additional days from the previous and next months are included as needed
  ///   to fill the grid so that it starts on Monday and ends on Sunday.
  List<DateTime> get getDaysOfMonth {
    // Get first day of that month
    final firstDayOfMonth = DateTime(year, month, 1);
    debugPrint("Masuk Sini");

    // than search first monday in that month
    DateTime firstMondayOfMonth = firstDayOfMonth;
    while (firstMondayOfMonth.weekday != DateTime.monday) {
      firstMondayOfMonth = firstMondayOfMonth.subtract(const Duration(days: 1));
    }

    // than search last sunday on that month
    DateTime firstDayNextMonth = DateTime(year, month + 1, 1);
    final lastDayOfMonth = firstDayNextMonth.subtract(const Duration(days: 1));
    DateTime lastSundayOfMonth = lastDayOfMonth;

    while (lastSundayOfMonth.weekday != DateTime.sunday) {
      lastSundayOfMonth = lastSundayOfMonth.add(const Duration(days: 1));
    }

    List<DateTime> days = [];
    DateTime date = firstMondayOfMonth;
    while (!date.isAfter(lastSundayOfMonth)) {
      days.add(date);
      date = date.add(const Duration(days: 1));
    }

    debugPrint("Keluar Sini");
    return days;
  }

  String get monthAndYear {
    final formatted = DateFormat('MMMM yyyy');
    return formatted.format(this);
  }

  bool isFirstDayOfMonth() {
    return day < 1;
  }

  bool isLastDayOfMonth() {
    // Get first day of the next month and subtract one day
    final firstDayOfNextMonth = DateTime(
      year,
      month + 1,
      1,
    ); // This will automatically roll over to the next year if needed
    final lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(
      const Duration(days: 1),
    );

    return day > lastDayOfCurrentMonth.day;
  }

  bool isBeforeDate(DateTime? otherDate) {
    if (otherDate == null) return false;
    final thisDateOnly = DateTime(year, month, day);
    final otherDateOnly = DateTime(
      otherDate.year,
      otherDate.month,
      otherDate.day,
    );

    return thisDateOnly.isBefore(otherDateOnly);
  }

  bool isAfterDate(DateTime? otherDate) {
    if (otherDate == null) return false;
    final thisDateOnly = DateTime(year, month, day);
    final otherDateOnly = DateTime(
      otherDate.year,
      otherDate.month,
      otherDate.day,
    );

    return thisDateOnly.isAfter(otherDateOnly);
  }

  bool isBetween(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) return false;
    return isAfterDate(startDate) && isBeforeDate(endDate);
  }

  bool isSameDate(DateTime? otherDate) {
    if (otherDate == null) return false;

    final sameYear = year == otherDate.year;
    final sameMonth = month == otherDate.month;
    final sameDay = day == otherDate.day;

    return sameYear && sameMonth && sameDay;
  }

  bool isSameMonth(DateTime other) {
    final sameMonth = month == other.month;

    return sameMonth;
  }

  String format(String format) {
    final formatter = DateFormat(format);
    return formatter.format(this);
  }
}

extension ListDateTimeExt on List<DateTime> {
  /// chunkSize 7
  List<List<DateTime>> chunkDates(int chunkSize) {
    List<List<DateTime>> chunks = [];
    for (int i = 0; i < length; i += chunkSize) {
      int end = (i + chunkSize < length) ? i + chunkSize : length;
      chunks.add(sublist(i, end));
    }
    return chunks;
  }
}

extension ListCalendarDataExt on List<CalendarData> {
  CalendarData? getCalendarData(DateTime date) {
    CalendarData? data;

    try {
      data = firstWhere((element) {
        return element.date.isSameDate(date);
      });
      return data;
    } catch (e) {
      return data;
    }
  }
}