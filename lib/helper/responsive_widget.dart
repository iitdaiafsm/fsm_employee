import 'package:flutter/material.dart';

const int largeScreenSize = 1366;
const int mediumScreenSize = 700;
const int smallScreenSize = 360;
const int customScreenSize = 1100;

class ResponsiveWidget extends StatelessWidget {
  final Widget? largeScreen;
  final Widget? mediumScreen;
  final Widget smallScreen;
  final Widget? customScreen;
  final Widget? drawer;
  final GlobalKey<ScaffoldState>? drawerKey;
  const ResponsiveWidget({
    this.largeScreen,
    Key? key,
    this.mediumScreen,
    required this.smallScreen,
    this.customScreen,
    this.drawer,
    this.drawerKey,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < mediumScreenSize;
  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= mediumScreenSize &&
          MediaQuery.of(context).size.width < largeScreenSize;
  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= largeScreenSize;
  static bool isCustomScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= mediumScreenSize &&
          MediaQuery.of(context).size.width < customScreenSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: drawerKey,
      drawer: drawer,
      body: LayoutBuilder(builder: ((context, constraints) {
        double _width = constraints.maxWidth;
        if (_width >= largeScreenSize) {
          return largeScreen ?? smallScreen;
        } else if (_width < largeScreenSize && _width >= mediumScreenSize) {
          return mediumScreen ?? smallScreen;
        } else {
          return smallScreen;
        }
      })),
    );
  }
}