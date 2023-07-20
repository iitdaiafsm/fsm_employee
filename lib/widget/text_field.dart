import 'package:flutter/material.dart';

import '../../helper/styles.dart';

class AppTextField extends StatelessWidget {
  TextEditingController textEditingController;
  TextInputType? keyboardType;
  bool readOnly;
  bool isLastField;
  IconData? icon;
  Function(String)? onChanged;
  String? hint;
  Color? primaryColor;
  Color? secondaryColor;
  int? maxLine;

  AppTextField({
    Key? key,
    required this.textEditingController,
    this.keyboardType,
    this.readOnly = false,
    this.isLastField = false,
    this.onChanged,
    this.hint,
    this.primaryColor,
    this.maxLine,
    this.secondaryColor,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getWidth(5, context), vertical: 0),
      child: TextField(

        scrollPadding: EdgeInsets.zero,
        controller: textEditingController,
        maxLines: maxLine ?? 1,
        style: textStyle(
          context: context,
          fontSize: FontSize.H4,
          color: primaryColor ?? Theme.of(context).shadowColor,
        ),
        obscureText: keyboardType == TextInputType.visiblePassword,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onChanged: onChanged,
        textInputAction:
            isLastField ? TextInputAction.done : TextInputAction.next,
        decoration: InputDecoration(
          isDense: false,

          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          icon: keyboardType == TextInputType.phone
              ? Padding(
                  padding: EdgeInsets.only(left: getWidth(3, context)),
                  child: Text(
                    "+91",
                    style: textStyle(
                      context: context,
                      fontSize: FontSize.H4,
                      color: primaryColor ?? Theme.of(context).shadowColor,
                    ),
                  ),
                )
              : null,
        ),
        cursorColor: secondaryColor ?? Theme.of(context).focusColor,
      ),
    );
  }
}
