import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../helper/calender_data_source.dart';
import '../../helper/models/user_model.dart';
import '../../main.dart';


class DashboardLogic extends GetxController {
  String greetingMessage = "";
  CalendarController calendarController = CalendarController();
  StreamController<AgendaDataSource> agendaDataSourceStream = StreamController<AgendaDataSource>();

  @override
  void onInit() {
    firebaseHelper.showAgenda().listen((event) {
      event.removeWhere((element) => (element.status=="Rejected" ||element.status=="Deleted") && element.userEmail != FirebaseAuth.instance.currentUser?.email);
      if(!agendaDataSourceStream.isClosed) {
        agendaDataSourceStream.sink.add(AgendaDataSource(event));
      }
    });
    getGreetingMessage();

    super.onInit();
  }
  Future<void> getGreetingMessage() async{
    var now = DateTime.now();
    UserModel userModel = await prefs.getUser();
    var hour = now.hour;

    if (hour < 12) {
      greetingMessage =  'Good Morning, ${userModel.name}';
    } else if (hour < 17) {
      greetingMessage =  'Good Afternoon, ${userModel.name}';
    } else {
      greetingMessage =  'Good Evening, ${userModel.name}';
    }
    update(["greeting"]);
  }
}
