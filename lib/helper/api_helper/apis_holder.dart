import 'package:fluttertoast/fluttertoast.dart';
import 'package:fsm_employee/helper/models/agenda_model.dart';
import 'package:fsm_employee/main.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../date_format_helper.dart';
import 'api_service.dart';

class ApiHolder {
  late ApiService _apiService;
  String username = 'cps@iafsm.in';
  String password = 'wfabtmbzyedeojem';
  late SmtpServer smtpServer;

  ApiHolder() {
    _apiService = ApiService();
    smtpServer = gmail(username, password);
  }

  Future<bool> applyLeaveNotification(AgendaModel agendaModel) async {
    var userModel = await prefs.getUser();
    var response = await _apiService.sendPushNotification(
        "Leave Apply",
        agendaModel.endDate != null
            ? "${userModel.name} applied for leave from ${DateFormatHelper.convertDateFromDate(agendaModel.startDate!, "dd-MM-yyyy")}${(agendaModel.startHalfDay ?? false) ? " (Half Day)" : ""} to ${DateFormatHelper.convertDateFromDate(agendaModel.endDate!, "dd-MM-yyyy")}${(agendaModel.endHalfDay ?? false) ? " (Half Day)" : ""}"
            : "${userModel.name} applied for leave day ${DateFormatHelper.convertDateFromDate(agendaModel.startDate!, "dd-MM-yyyy")}${(agendaModel.startHalfDay ?? false) ? " (Half Day)" : ""}",
        userModel.email ?? "");
    var response1 = await _apiService.sendPushNotificationToAdmin(
        "Leave Apply",
        agendaModel.endDate != null
            ? "${userModel.name} applied for leave from ${DateFormatHelper.convertDateFromDate(agendaModel.startDate!, "dd-MM-yyyy")}${(agendaModel.startHalfDay ?? false) ? " (Half Day)" : ""} to ${DateFormatHelper.convertDateFromDate(agendaModel.endDate!, "dd-MM-yyyy")}${(agendaModel.endHalfDay ?? false) ? " (Half Day)" : ""}"
            : "${userModel.name} applied for leave day ${DateFormatHelper.convertDateFromDate(agendaModel.startDate!, "dd-MM-yyyy")}${(agendaModel.startHalfDay ?? false) ? " (Half Day)" : ""}",
        userModel.email ?? "");

    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Leave Application')
      ..recipients.add('suniljha@iafsm.in')
      // ..recipients.add('sanjeev081097@gmail.com')
      ..subject = 'Leave Apply : ${userModel.name}'
      ..html = '''
<p style="margin-left:1px; text-align:center">&nbsp;</p>

<h2>Respected sir,</h2>

<h3>I, ${userModel.name}, am applying for leave -</h3>

<h3>Reason - ${agendaModel.reason}</h3>

<h3>Start Date - ${DateFormatHelper.convertDateFromDate(agendaModel.startDate!, "dd-MM-yyyy")}${(agendaModel.startHalfDay ?? false) ? " (Half Day)" : ""}</h3>

${agendaModel.endDate!=null?'<h3>End date - ${DateFormatHelper.convertDateFromDate(agendaModel.endDate!, "dd-MM-yyyy")}${(agendaModel.endHalfDay ?? false) ? " (Half Day)" : ""}</h3>':''}

<h3>Requesting you to approve the same.</h3>

<h3>Click <a href="https://fsm-employee.web.app/">here</a>&nbsp;to approve leave.</h3>

      ''';

    try {
      final sendReport = await send(message, smtpServer);
      Fluttertoast.showToast(msg: "Email sent");
    } on MailerException catch (e) {
      Fluttertoast.showToast(msg: "Email sending failed : $e");
    }
    return response && response1;
  }

  Future<void> sendDeleteLeaveEmail(AgendaModel agendaModel) async {
    var userModel = await prefs.getUser();

    final message = Message()
      ..from = Address(username, 'Leave Application')
      ..recipients.add('suniljha@iafsm.in')
      // ..recipients.add('sanjeev081097@gmail.com')
      ..subject = 'Leave Delete Request : ${userModel.name}'
      ..html = '''
<p style="margin-left:1px; text-align:center">&nbsp;</p>

<h2>Respected sir,</h2>

<h3>I hope this email finds you well. I am writing to inform you that I need to cancel my previously approved leave, which was scheduled from ${DateFormatHelper.convertDateFromDate(agendaModel.startDate!, "dd-MM-yyyy")}${(agendaModel.startHalfDay ?? false) ? " (Half Day)" : ""} to ${DateFormatHelper.convertDateFromDate(agendaModel.endDate!, "dd-MM-yyyy")}${(agendaModel.endHalfDay ?? false) ? " (Half Day)" : ""}.</h3>

<h3>Best regards,</h3>

<h3>${userModel.name}</h3>

      ''';

    try {
      final sendReport = await send(message, smtpServer);
      Fluttertoast.showToast(msg: "Email sent");
    } on MailerException catch (e) {
      Fluttertoast.showToast(msg: "Email sending failed : $e");
    }
  }
}
