import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fsm_employee/helper/api_helper/apis_holder.dart';
import 'package:fsm_employee/helper/notification_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';
import 'helper/firebase_helper.dart';
import 'helper/prefs.dart';
import 'helper/routes.dart';
import 'helper/theme_controller.dart';
import 'helper/theme_data.dart';

late Prefs prefs;
var currentRoute = Routes.INITIAL_ROUTE;
late FirebaseHelper firebaseHelper;
late FirebaseMessaging messaging;
late NotificationService notificationService;
late ApiHolder apiHolder;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Background : ${message.data}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  firebaseHelper = FirebaseHelper();
  await GetStorage.init();
  apiHolder = ApiHolder();
  prefs = Prefs();
  messaging = FirebaseMessaging.instance;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  notificationService = NotificationService();
  await NotificationService().init();

  await messaging.subscribeToTopic("leave");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    var userModel = await prefs.getUser();

    if (userModel.email != null &&
        userModel.email != message.data["user_email"]) {
      notificationService.showNotifications(
        titleText: message.notification?.title ?? "",
        bodyText: message.notification?.body ?? "",
      );
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ThemeController controller = Get.put(ThemeController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FSM Employee',
      debugShowCheckedModeBanner: false,
      initialRoute: currentRoute,
      getPages: Routes.routes,
      theme: theme0,
      // home: DashboardPage(),
    );
  }
}
