import 'package:fsm_employee/screens/login/login_view.dart';
import 'package:fsm_employee/screens/main/main_view.dart';
import 'package:fsm_employee/screens/splash/splash_view.dart';
import 'package:get/get.dart';

class Routes {
  static const INITIAL_ROUTE = "/";
  static const MAIN_PAGE = "/main-page";
  static const LOGIN_PAGE = "/login-page";
  static final routes = [
    GetPage(
      name: INITIAL_ROUTE,
      page: () => SplashPage(),
    ),
    GetPage(
      name: MAIN_PAGE,
      page: () => MainPage(),
    ),
    GetPage(
      name: LOGIN_PAGE,
      page: () => LoginPage(),
      transition: Transition.fadeIn,
    ),
  ];
}
