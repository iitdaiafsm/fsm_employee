import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fsm_employee/helper/flutter_bounce.dart';
import 'package:fsm_employee/helper/routes.dart';
import 'package:fsm_employee/helper/styles.dart';
import 'package:fsm_employee/main.dart';
import 'package:fsm_employee/screens/main/main_logic.dart';
import 'package:fsm_employee/widget/app_drawer/controller.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.7,
      height: height(context),
      child: Stack(
        children: [
          Image.asset(
            "asset/app_drawer_bg.png",
            fit: BoxFit.fitHeight,
            width: width(context) * 0.7,
            height: height(context),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GetBuilder<AppDrawerController>(
                    init: AppDrawerController(),
                    assignId: true,
                    builder: (logic) {
                      return Bounce(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  border: Border.all()),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: CachedNetworkImage(
                                  imageUrl: logic.userModel.profilePic ?? "",
                                  placeholder: (ctx, str) {
                                    return Image.asset(
                                      "asset/logo_fsm.jpg",
                                      width: width(context) * 0.15,
                                      height: width(context) * 0.15,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                  errorWidget: (ctx, str, dyn) {
                                    return Image.asset(
                                      "asset/logo_fsm.jpg",
                                      width: width(context) * 0.15,
                                      height: width(context) * 0.15,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    logic.userModel.name ?? "",
                                    style: textStyle(
                                      context: context,
                                      fontSize: FontSize.H2,
                                      isBold: true,
                                    ),
                                  ),
                                  Text(
                                    logic.userModel.email ?? "",
                                    style: textStyle(
                                      context: context,
                                      fontSize: FontSize.H4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                  ),
                  getMenuItem(context, "Dashboard", () {
                    MainLogic mainLogic = Get.put<MainLogic>(MainLogic());
                    mainLogic.changePage("Dashboard");
                    Get.back();
                  }),
                  getMenuItem(context, "My Leaves", () {
                    MainLogic mainLogic = Get.put<MainLogic>(MainLogic());
                    mainLogic.changePage("My Leaves");
                    Get.back();
                  }),
                  getMenuItem(context, "Apply Leave", () {
                    MainLogic mainLogic = Get.put<MainLogic>(MainLogic());
                    mainLogic.changePage("Apply Leave");
                    Get.back();
                  }),
                  /*getMenuItem(context, "Send Email", () async {
                    String username = 'cps@iafsm.in';
                    String password = 'wfabtmbzyedeojem';

                    final smtpServer = gmail(username, password);
                    // Use the SmtpServer class to configure an SMTP server:
                    // final smtpServer = SmtpServer('smtp.domain.com');
                    // See the named arguments of SmtpServer for further configuration
                    // options.

                    // Create our message.
                    final message = Message()
                      ..from = Address(username, 'Leave Application')
                    // ..recipients.add('suniljha@iafsm.in')
                      ..recipients.add('sanjeev.kumar@iafsm.in')
                      ..subject = 'Leave Apply : Sanjeev Kumar'
                      ..html = '''
<p style="margin-left:1px; text-align:center">&nbsp;</p>

<h2>Respected sir,</h2>

<h3>I, Sanjeev Kumar, am applying for leave -</h3>

<h3>Reason - Going to home</h3>

<h3>Start Date - 06 March</h3>

<h3>End date - 07 March</h3>

<h3>Requesting you to approve the same.</h3>

<h3>Click <a href="https://fsm-employee.web.app/">here</a>&nbsp;to approve leave.</h3>

      ''';

                    try {
                      final sendReport = await send(message, smtpServer);
                      print('Message sent: ' + sendReport.toString());
                    } on MailerException catch (e) {
                      print('Message not sent. $e');
                      for (var p in e.problems) {
                        print('Problem: ${p.code}: ${p.msg}');
                      }
                    }
                  }),*/
                  getMenuItem(context, "Logout", () async {
                    await prefs.clearUser();
                    await firebaseHelper.logout();
                    Get.offAllNamed(Routes.LOGIN_PAGE);
                  }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getMenuItem(BuildContext context, String title, Function() onPressed) {
    return Column(
      children: [
        Bounce(
          onPressed: onPressed,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: textStyle(
                    context: context,
                    fontSize: FontSize.H1,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
