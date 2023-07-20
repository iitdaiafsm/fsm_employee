import 'package:flutter/material.dart';
import 'package:fsm_employee/helper/responsive_widget.dart';
import 'package:fsm_employee/widget/social_button/constants.dart';
import 'package:fsm_employee/widget/social_button/create_button.dart';
import 'package:get/get.dart';

import '../../helper/styles.dart';
import 'login_logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginLogic>(
      init: LoginLogic(),
      builder: (logic) {
        return ResponsiveWidget(
          smallScreen: Container(
            width: width(context),
            height: height(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColorDark,
                  Theme.of(context).scaffoldBackgroundColor
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: getHeight(20, context),
                  ),
                  Image.asset(
                    "asset/login.png",
                  ),
                  SizedBox(
                    height: getHeight(10, context),
                  ),
                  Expanded(
                    child: Center(
                      child: logic.isLoading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                              ),
                            )
                          : SignInButton(
                              buttonType: ButtonType.google,
                              onPressed: () {
                                logic.googleLogin(context);
                              },
                            ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(10, context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
