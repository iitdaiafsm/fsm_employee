import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fsm_employee/helper/models/user_model.dart';
import 'package:fsm_employee/helper/routes.dart';
import 'package:fsm_employee/main.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../helper/permission_controller.dart';


class SplashLogic extends GetxController {
  @override
  void onInit() {
    initializedVar();
    setUpNotification();
    super.onInit();
  }

  void initializedVar() async{
    UserModel userModel = await prefs.getUser();

    Future.delayed(Duration(seconds: 3),(){
      Get.offAllNamed(userModel.email != null ?Routes.MAIN_PAGE: Routes.LOGIN_PAGE);
    });

  }

  Future<void> setUpNotification() async {
    await PermissionController.havePermission(Permission.notification);
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
}
