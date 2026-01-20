import 'package:custom_date_time/components/utils/calendar_data.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart' hide DatePickerMode;

import 'components/dialog/show_calendar_picker.dart';

void main() {
  runApp(DevicePreview(builder: (context) => const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: Scaffold(
        appBar: AppBar(title: const Text('Calendar')),
        body: ListView(
          children: [
            Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    final data = await showCalendarPicker(
                      context: context,
                      backgroundColor: const Color(0xFFFDEFC4),
                      backgroundHeaderColor: const Color(0xFFD4A373),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black),
                      mode: DatePickerMode.single,
                    );
                    debugPrint("data $data");
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
