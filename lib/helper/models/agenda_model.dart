import '../date_format_helper.dart';

class AgendaModel {
  String? reason;
  DateTime? startDate;
  DateTime? endDate;
  String? userName;
  String? userEmail;
  String? type;
  String? status;
  int? timestamp;
  bool? startHalfDay;
  bool? endHalfDay;
  String? version;

  AgendaModel({
    this.reason,
    this.startDate,
    this.endDate,
    this.userName,
    this.userEmail,
    this.type,
    this.status = "Pending",
    this.timestamp,
    this.endHalfDay,
    this.startHalfDay,
    this.version,
  });

  AgendaModel.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    try {
      startDate = DateFormatHelper.convertToDateFromString(
          json['start_date'], "dd-MM-yyyy hh:mm a");
    } catch (e) {
      startDate = DateFormatHelper.convertToDateFromString(
          json['start_date'], "dd-MM-yyyy");
    }
    try {
      endDate = DateFormatHelper.convertToDateFromString(
          json['end_date'], "dd-MM-yyyy hh:mm a");
    } catch (e) {
      endDate = DateFormatHelper.convertToDateFromString(
          json['end_date'], "dd-MM-yyyy");
    }
    userName = json['user_name'];
    userEmail = json['user_email'];
    type = json['type'];
    status = json['status'] ?? "Pending";
    timestamp = json['timestamp'];
    startHalfDay = json['start_half_day'];
    endHalfDay = json['end_half_day'];
    version = json['version']??"V1";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reason'] = reason;
    data['start_date'] = DateFormatHelper.convertDateFromDate(
        startDate ?? DateTime.now(), "dd-MM-yyyy");
    data['end_date'] = DateFormatHelper.convertDateFromDate(
        endDate ?? DateTime.now(), "dd-MM-yyyy");
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['type'] = type;
    data['status'] = status;
    data['timestamp'] = timestamp;
    data['start_half_day'] = startHalfDay;
    data['end_half_day'] = endHalfDay;
    data['version'] = version;
    return data;
  }
}
