import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/responsive_widget.dart';
import '../../helper/styles.dart';
import 'splash_logic.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashLogic>(
      init: SplashLogic(),
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
                      child: Text(
                        "FSM Employee",
                        style: textStyle(
                          context: context,
                          isBold: true,
                          fontSize: FontSize.TITLE,
                        ),
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
