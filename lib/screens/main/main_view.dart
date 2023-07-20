import 'package:flutter/material.dart';
import 'package:fsm_employee/helper/calender_data_source.dart';
import 'package:fsm_employee/helper/flutter_bounce.dart';
import 'package:fsm_employee/helper/responsive_widget.dart';
import 'package:fsm_employee/screens/dashboard/dashboard_view.dart';
import 'package:fsm_employee/screens/my_leaves/my_leaves_view.dart';
import 'package:fsm_employee/widget/app_drawer/app_drawer.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../helper/styles.dart';
import '../apply_leave/apply_leave_view.dart';
import 'main_logic.dart';

class MainPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      drawerKey: _key,
      drawer: AppDrawer(),
      smallScreen: Container(
        width: width(context),
        height: height(context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme
                  .of(context)
                  .primaryColorDark,
              Theme
                  .of(context)
                  .scaffoldBackgroundColor
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Bounce(
                  onPressed: () {
                    _key.currentState?.openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    color: Theme
                        .of(context)
                        .primaryColor,
                    size: 30,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: GetBuilder<MainLogic>(
                    init: MainLogic(),
                    didChangeDependencies: (state){
                      state.controller?.checkVersion(context);
                    },
                    id: "page",
                    builder: (logic) {
                      switch (logic.page){
                        case "Dashboard":
                          return DashboardPage();
                        case "My Leaves":
                          return MyLeavesPage();
                        case "Apply Leave":
                          return ApplyLeavePage();
                        default:
                          return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
