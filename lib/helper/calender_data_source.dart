import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'models/agenda_model.dart';

class AgendaDataSource extends CalendarDataSource<AgendaModel> {
  AgendaDataSource(this.source);

  List<AgendaModel> source;

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].startDate ?? DateTime.now();
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].endDate ?? DateTime.now();
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  @override
  String getSubject(int index) {
    return "${source[index].userName} : ${source[index].reason}";
  }

  @override
  Color getColor(int index) {
    switch (source[index].status){
      case "Pending":
        return Colors.yellow[800]!;
      case "Approved":
        return Colors.green[800]!;
      case "Rejected":
        return Colors.red[800]!;
      case "Deleted":
        return Colors.grey[800]!;
      default:
        return Colors.yellow[800]!;
    }
  }

  @override
  AgendaModel convertAppointmentToObject(
      AgendaModel eventName, Appointment appointment) {
    return AgendaModel(
      reason: appointment.subject,
      startDate: appointment.startTime,
      endDate: appointment.endTime,
    );
  }
}
