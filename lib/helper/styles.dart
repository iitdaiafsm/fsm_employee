import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'responsive_widget.dart';

TextStyle textStyle({
  Color? color,
  required BuildContext context,
  FontSize? fontSize,
  bool isBold = false,
  bool isItalic = false,
  bool haveShadow = false,
  TextDecoration textDecoration = TextDecoration.none,
  bool isCard = false,
}) {
  return isCard
      ? GoogleFonts.lora(
          color: color ?? Theme.of(context).primaryColor,
          fontSize: _getFontSize(fontSize ?? FontSize.H3, context),
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
          decoration: textDecoration,
          shadows: haveShadow
              ? [
                  const Shadow(
                    blurRadius: 4,
                    color: Colors.white,
                    offset: Offset(-3, 3),
                  ),
                ]
              : null,
        )
      : GoogleFonts.openSans(
          color: color ?? Theme.of(context).primaryColor,
          fontSize: _getFontSize(fontSize ?? FontSize.H4, context),
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
          decoration: textDecoration,
          shadows: haveShadow
              ? [
                  const Shadow(
                    blurRadius: 4,
                    color: Colors.white,
                    offset: Offset(-3, 3),
                  ),
                ]
              : null,
        );
}

_getFontSize(FontSize fontSize, BuildContext context) {
  switch (fontSize) {
    case FontSize.H1:
      return getWidth(10+2, context) *
          (ResponsiveWidget.isLargeScreen(context)
              ? 1
              : ResponsiveWidget.isMediumScreen(context)
                  ? 2
                  : 3);

    case FontSize.H2:
      return getWidth(9+2, context) *
          (ResponsiveWidget.isLargeScreen(context)
              ? 1
              : ResponsiveWidget.isMediumScreen(context)
                  ? 2
                  : 3);

    case FontSize.H3:
      return getWidth(8+2, context) *
          (ResponsiveWidget.isLargeScreen(context)
              ? 1
              : ResponsiveWidget.isMediumScreen(context)
                  ? 2
                  : 3);

    case FontSize.H4:
      return getWidth(7+2, context) *
          (ResponsiveWidget.isLargeScreen(context)
              ? 1
              : ResponsiveWidget.isMediumScreen(context)
                  ? 2
                  : 3);

    case FontSize.H5:
      return getWidth(6+2, context) *
          (ResponsiveWidget.isLargeScreen(context)
              ? 1
              : ResponsiveWidget.isMediumScreen(context)
                  ? 2
                  : 3);

    case FontSize.H6:
      return getWidth(5+2, context) *
          (ResponsiveWidget.isLargeScreen(context)
              ? 1
              : ResponsiveWidget.isMediumScreen(context)
                  ? 2
                  : 3);
    case FontSize.H7:
      return getWidth(4+2, context) *
          (ResponsiveWidget.isLargeScreen(context)
              ? 1
              : ResponsiveWidget.isMediumScreen(context)
                  ? 2
                  : 3);
    case FontSize.TITLE:
      return getWidth(16+2, context) *
          (ResponsiveWidget.isLargeScreen(context)
              ? 1
              : ResponsiveWidget.isMediumScreen(context)
                  ? 2
                  : 3);
  }
}

double width(BuildContext context) => MediaQuery.of(context).size.width;

double height(BuildContext context) => MediaQuery.of(context).size.height;

double getWidth(double size, BuildContext context) {
  double _width = MediaQuery.of(context).size.width;
  return _width * (size / 750);
}

double getHeight(double size, BuildContext context) {
  double _height = MediaQuery.of(context).size.height;
  return _height * (size / 750);
}

enum FontSize {
  H1,
  H2,
  H3,
  H4,
  H5,
  H6,
  H7,
  TITLE,
}
