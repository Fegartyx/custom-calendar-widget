import 'package:custom_date_time/components/calendar_widget.dart';
import 'package:custom_date_time/components/utils/calendar_utils.dart';
import 'package:flutter/material.dart' hide DatePickerMode;

import 'components/dialog/show_calendar_picker.dart';

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
                    showCalendarPicker(
                      context: context,
                      backgroundColor: Colors.white,
                      backgroundHeaderColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      mode: DatePickerMode.single,
                      contentBasicTextColor: Colors.green,
                      contentTodayTextColor: Colors.red,
                      contentSelectedDateColor: Colors.red,
                    );
                  },
                  child: const Text('Show Dialog'),
                );
              }
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
