import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:fsm_employee/main.dart';
import 'package:get/get.dart';

import '../../helper/models/agenda_model.dart';


class MyLeavesLogic extends GetxController {
  List<AgendaModel> leaves = [];
  bool isLoading = false;
  bool isDeleteButtonLoading = false;
  @override
  void onInit() {
    getLeaves();
    super.onInit();
  }

  void getLeaves() async{
    isLoading = true;
    update(["leave"]);
    leaves = await firebaseHelper.myLeaves();
    isLoading = false;
    update(["leave"]);
  }

  void deleteLeave(BuildContext context, AgendaModel agendaModel) async{

    isDeleteButtonLoading = true;
    update(["leave"]);
    agendaModel.status = "Deleted";
    await firebaseHelper.deleteLeave(agendaModel);
    await apiHolder.sendDeleteLeaveEmail(agendaModel);
    isDeleteButtonLoading = false;
    update(["leave"]);
  }
}
