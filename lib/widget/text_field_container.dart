import 'package:flutter/material.dart';

import '../../helper/styles.dart';

class TextFieldContainer extends StatelessWidget {
  TextEditingController textEditingController;
  TextInputType? keyboardType;
  bool readOnly;
  bool isLastField;
  IconData? icon;
  String? hint;
  String title;
  Color? primaryColor;
  Color? secondaryColor;
  int? maxLine;
  Function(String)? onChanged;
  bool isPasswordType;
  void Function()? onToggle;
  String? Function(String?)? validator;

  TextFieldContainer({
    Key? key,
    required this.textEditingController,
    this.keyboardType,
    this.readOnly = false,
    this.isLastField = false,
    this.hint,
    this.onChanged,
    this.primaryColor,
    this.secondaryColor,
    this.icon,
    this.maxLine,
    required this.title,
    this.onToggle,
    this.validator,
    this.isPasswordType = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: EdgeInsets.zero,
      controller: textEditingController,
      maxLines: maxLine ?? 1,
      style: textStyle(
        context: context,
        fontSize: FontSize.H2,
        color: primaryColor ?? Theme.of(context).primaryColorDark,
      ),
      obscureText: keyboardType == TextInputType.visiblePassword,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onChanged: onChanged,
validator: validator,
      textInputAction:
          isLastField ? TextInputAction.done : TextInputAction.next,
      decoration: InputDecoration(
        labelText: title,
        isDense: false,
        hintText: hint,
        hintStyle: textStyle(context: context,color: Theme.of(context).focusColor),
        labelStyle: textStyle(context: context,color: Theme.of(context).cardColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.blue),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.green),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.all(8),
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
    );
  }
}
