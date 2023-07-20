import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fsm_employee/helper/firebase_helper.dart';
import 'package:fsm_employee/helper/models/user_model.dart';
import 'package:fsm_employee/helper/routes.dart';
import 'package:fsm_employee/main.dart';
import 'package:get/get.dart';


class LoginLogic extends GetxController {
  bool isLoading=  false;

  Future<void> googleLogin(BuildContext context) async {
    isLoading = true;
    update();
    var user = await firebaseHelper.loginWithGoogle();
    if(user != null){
      UserModel userModel = UserModel(name: user.displayName,email: user.email);
      var emails = await firebaseHelper.getAuthoriseUsers();
      if(emails.isNotEmpty && emails.contains(userModel.email)){
        await firebaseHelper.registerUser(userModel);
        await prefs.setUser(userModel);
        Get.offAllNamed(Routes.MAIN_PAGE);
      }else{
        Fluttertoast.showToast(msg: "You are not authorise to access this app.");
      }
    }
    isLoading = false;
    update();
  }
}
