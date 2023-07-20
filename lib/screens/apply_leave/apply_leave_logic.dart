import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fsm_employee/helper/date_format_helper.dart';
import 'package:fsm_employee/helper/models/agenda_model.dart';
import 'package:fsm_employee/helper/models/user_model.dart';
import 'package:fsm_employee/main.dart';
import 'package:get/get.dart';

import '../main/main_logic.dart';

class ApplyLeaveLogic extends GetxController {
  TextEditingController reasonController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  bool isHalfDayStart = false;
  bool isHalfDayEnd = false;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void onSubmit(BuildContext context) async {
    print("Reason : ${reasonController.text.trim()}");
    print("Start Date : ${startDateController.text.trim()}");
    print("End Date : ${endDateController.text.trim()}");
    print("Start Half : $isHalfDayStart");
    print("End Half : $isHalfDayEnd");
    UserModel userModel = await prefs.getUser();
    if (formKey.currentState?.validate() ?? false) {
      AgendaModel agendaModel = AgendaModel(
        type: "Leave",
        reason: reasonController.text.trim(),
        endDate:endDateController.text.trim().isNotEmpty? DateFormatHelper.convertToDateFromString(
            endDateController.text.trim(), "yyyy-MM-dd"):null,
        startDate: DateFormatHelper.convertToDateFromString(
            startDateController.text.trim(), "yyyy-MM-dd"),
        userEmail: userModel.email,
        userName: userModel.name,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        status: "Pending",
        endHalfDay: isHalfDayEnd,
        startHalfDay: isHalfDayStart,
        version: "V2",
      );
      isLoading = true;
      update();
      await firebaseHelper.addAgenda(agendaModel);
      isLoading = false;
      reasonController.clear();
      startDateController.clear();
      endDateController.clear();
      update();
      apiHolder.applyLeaveNotification(
          agendaModel);
      Fluttertoast.showToast(msg: "Leave Applied!");
      MainLogic mainLogic = Get.put<MainLogic>(MainLogic());
      mainLogic.changePage("My Leaves");
    }
  }
}
