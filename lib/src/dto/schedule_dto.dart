import 'dart:ui';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class Schedule {
  Schedule(this.id, this.eventName, this.from, this.to, this.background,
      this.isAllDay, this.isBooked);

  String eventName;
  String id;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  bool isBooked;
}

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<Schedule> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
