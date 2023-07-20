import 'package:fsm_employee/helper/models/user_model.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../main.dart';

class AppDrawerController extends GetxController {

  UserModel userModel = UserModel();
  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  void getUserData() async{
    userModel = await prefs.getUser();
    update();
  }
}