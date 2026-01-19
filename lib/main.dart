import 'package:custom_date_time/components/calendar_widget.dart';
import 'package:custom_date_time/components/utils/calendar_utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Calendar')),
        body: ListView(
          children: [
            Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: const SingleSelectionCalendar(),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Show Dialog'),
                );
              },
            ),
            // const SingleSelectionCalendar(),
            // const SizedBox(height: 32),
            // const RangeSelectionCalendar(),
          ],
        ),
      ),
    );
  }
}

class SingleSelectionCalendar extends StatefulWidget {
  final Color? backgroundColor;
  const SingleSelectionCalendar({super.key, this.backgroundColor});

  @override
  State<SingleSelectionCalendar> createState() =>
      _SingleSelectionCalendarState();
}

class _SingleSelectionCalendarState extends State<SingleSelectionCalendar> {
  final dateNotifier = ValueNotifier<DateTime?>(null);

  @override
  void dispose() {
    dateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dateNotifier,
      builder: (context, selectedDate, _) {
        return Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CalendarWidget.single(
                selectedDate: selectedDate,
                onDateSelected: (date) {
                  dateNotifier.value = date;
                },
                disableSelection: (date) {
                  final isFirst = date.isFirstDayOfMonth();
                  final isLast = date.isLastDayOfMonth();

                  return isFirst || isLast;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      debugPrint("selected $selectedDate ${dateNotifier.value}");
                      Navigator.of(context).pop();
                    },
                    child: const Text("CANCEL"),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      debugPrint("selected $selectedDate ${dateNotifier.value}");
                      Navigator.pop(context, selectedDate);
                    },
                    child: const Text("OK"),
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
  const RangeSelectionCalendar({super.key});

  @override
  State<RangeSelectionCalendar> createState() => _RangeSelectionCalendarState();
}

class _RangeSelectionCalendarState extends State<RangeSelectionCalendar> {
  final startDateNotifier = ValueNotifier<DateTime?>(null);
  final endDateNotifier = ValueNotifier<DateTime?>(null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: Listenable.merge([startDateNotifier, endDateNotifier]),
          builder: (context, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CalendarWidget.range(
                  selectedStartDate: startDateNotifier.value,
                  selectedEndDate: endDateNotifier.value,
                  onStartDateSelected: (date) {
                    startDateNotifier.value = date;
                  },
                  onEndDateSelected: (date) {
                    endDateNotifier.value = date;
                  },
                  // calendarData: [
                  //   CalendarData(date: DateTime(2026, 01, 05), info: "20"),
                  //   CalendarData(date: DateTime(2026, 01, 07), info: "25"),
                  // ],
                ),
                const SizedBox(height: 16),
                Text(
                  "Selected Start Date : ${startDateNotifier.value?.format("dd MMMM yyyy") ?? "-"}",
                ),
                Text(
                  "Selected End Date : ${endDateNotifier.value?.format("dd MMMM yyyy") ?? "-"}",
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
