import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fsm_employee/helper/models/user_model.dart';
import 'package:fsm_employee/main.dart';
import 'package:fsm_employee/widget/update_dialog.dart';
import 'package:get/get.dart';

import '../../helper/routes.dart';

class MainLogic extends GetxController {
  late String page;

  @override
  void onInit() {
    page = "Dashboard";
    getCurrentSavedUser();
    super.onInit();
  }

  void changePage(String newPage) {
    if (page != newPage) {
      page = newPage;
    }
    update(["page"]);
  }

  void getCurrentSavedUser() async {
    UserModel userModel = await prefs.getUser();
    if (userModel.email != null) {
      var emails = await firebaseHelper.getAuthoriseUsers();
      if (!emails.contains(userModel.email)) {
        Fluttertoast.showToast(
            msg:
                "Sorry!!!, you are not authorise FSM Employee App. Logging Out...");
        await prefs.clearUser();
        await firebaseHelper.logout();
        Get.offAllNamed(Routes.LOGIN_PAGE);
      }else{
        String? token = await messaging.getToken(
        );
        if(token != null){
          Get.log(token);
          await firebaseHelper.setUserToken(token??"");
        }
      }
    }
  }

  void checkVersion(BuildContext context) async {
    Map<String, dynamic> map = await firebaseHelper.getAppVersion();
    if (map["version"] != "1.0.0" || map["build_number"] != "5") {
      Get.dialog(

        UpdateDialog(),
        barrierDismissible: false
      );
    }
  }
}
