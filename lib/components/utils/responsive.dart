import 'package:flutter/material.dart';

extension ResponsiveDouble on num {
  double r(BuildContext context) => Responsive.responsiveScale(context, toDouble());
}

extension ResponsivePaddingAndMargin on EdgeInsets {
  EdgeInsets r(BuildContext context) => copyWith(
    left: left.r(context),
    top: top.r(context),
    right: right.r(context),
    bottom: bottom.r(context),
  );
}

extension ResponsiveOffset on Offset {
  Offset r(BuildContext context) => Offset(dx.r(context), dy.r(context));
}

extension ResponsiveRadius on Radius {
  Radius r(BuildContext context) => Radius.elliptical(x.r(context), y.r(context));
}

extension ResponsiveBorderRadius on BorderRadius {
  BorderRadius r(BuildContext context) => copyWith(
    topLeft: topLeft.r(context),
    topRight: topRight.r(context),
    bottomLeft: bottomLeft.r(context),
    bottomRight: bottomRight.r(context),
  );
}

extension ResponsiveTheme on TextStyle {
  TextStyle r(BuildContext context) => copyWith(fontSize: fontSize?.r(context));
}

extension ResponsiveSize on Size {
  Size r(BuildContext context) => Size(width.r(context), height.r(context));
}

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600 &&
          MediaQuery.sizeOf(context).width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1024;

  static double scale(BuildContext context) => isDesktop(context) ? 2.4 : isTablet(context) ? 1.6 : 1.0;

  static double responsiveScale(BuildContext context, double baseSize) {
    return baseSize * Responsive.scale(context);
  }

  static SizedBox SBox(BuildContext context, {double? height, double? width}) {
    return SizedBox(height: height?.r(context), width: width?.r(context),);
  }
}