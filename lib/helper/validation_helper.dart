import 'package:fluttertoast/fluttertoast.dart';

class Validator {
  static bool validateEmail(
      String value, String? emptyText, String? errorText) {
    if (value.isEmpty) {
      Fluttertoast.showToast(msg: emptyText ?? "Enter Email");
      return false;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      Fluttertoast.showToast(msg: errorText ?? "Enter valid Email");
      return false;
    } else {
      return true;
    }
  }

  static bool validateName(String value, String? emptyText, String? errorText) {
    if (value.isEmpty) {
      Fluttertoast.showToast(msg: emptyText ?? "Enter Name");
      return false;
    } else if (!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$")
        .hasMatch(value)) {
      Fluttertoast.showToast(msg: errorText ?? "Enter valid Name");
      return false;
    } else {
      return true;
    }
  }

  static bool validateImage(String value) {
    if (value.isEmpty) {
      Fluttertoast.showToast(msg: "Select Image");
      return false;
    } else {
      return true;
    }
  }

  static bool validatePhone(
      String value, bool optional, String? emptyText, String? errorText) {
    if (optional) {
      if (value.isEmpty) {
        return true;
      } else {
        if (!RegExp(r"^[6-9]\d{9}$").hasMatch(value)) {
          Fluttertoast.showToast(msg: errorText ?? "Enter valid phone");
          return false;
        } else {
          return true;
        }
      }
    } else {
      if (value.isEmpty) {
        Fluttertoast.showToast(msg: emptyText ?? "Enter phone");
        return false;
      } else {
        if (!RegExp(r"^[6-9]\d{9}$").hasMatch(value)) {
          Fluttertoast.showToast(msg: errorText ?? "Enter valid phone");
          return false;
        } else {
          return true;
        }
      }
    }
  }
}
