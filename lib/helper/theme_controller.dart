import 'package:flutter/src/material/theme_data.dart';
import 'package:get/get.dart';

import '../main.dart';
import 'theme_data.dart';

class ThemeController extends GetxController {
  int themeIndex = 0;
  List<ThemeData> themeDataList = [
    theme0,
    theme1,
    theme2,
    theme3,
    theme4,
    theme5,
    theme6,
    theme7,
  ];
  @override
  void onInit() {
    getTheme();
    super.onInit();
  }

  void getTheme() async {
    themeIndex = await prefs.getTheme();
    Get.changeTheme(getThemeData());
    update();
  }

  void setTheme(int index) async {
    themeIndex = index;
    prefs.setTheme(themeIndex);
    Get.changeTheme(getThemeData());
    update();
  }

  ThemeData getThemeData() {
    return themeDataList[themeIndex];
  }
}
