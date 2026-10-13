import 'package:flutter/material.dart';

enum DeviceType { phone, tablet, desktop }

class Responsive {
  Responsive._();

  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 840;

  static DeviceType deviceType(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= desktopBreakpoint) return DeviceType.desktop;
    if (w >= tabletBreakpoint) return DeviceType.tablet;
    return DeviceType.phone;
  }

  static bool isTablet(BuildContext context) =>
      deviceType(context) == DeviceType.tablet;

  static bool isPhone(BuildContext context) =>
      deviceType(context) == DeviceType.phone;

  static bool isDesktop(BuildContext context) =>
      deviceType(context) == DeviceType.desktop;

  static T value<T>(
    BuildContext context, {
    required T phone,
    T? tablet,
    T? desktop,
  }) {
    final type = deviceType(context);
    if (type == DeviceType.desktop && desktop != null) return desktop;
    if (type == DeviceType.tablet && tablet != null) return tablet;
    return phone;
  }

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  static EdgeInsets safePadding(BuildContext context) =>
      MediaQuery.of(context).padding;

  static double bottomSafeArea(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;

  static double topSafeArea(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static double systemGestureInsetBottom(BuildContext context) =>
      MediaQuery.of(context).systemGestureInsets.bottom;

  static double maxContentWidth(BuildContext context) {
    final w = screenWidth(context);
    if (w > 840) return 840;
    if (w > 600) return w - 48;
    return w - 32;
  }

  static double padding(BuildContext context) =>
      value(context, phone: 10.0, tablet: 24.0, desktop: 32.0);

  static double cardPadding(BuildContext context) =>
      value(context, phone: 10.0, tablet: 20.0, desktop: 24.0);

  static double spacing(BuildContext context) =>
      value(context, phone: 12.0, tablet: 16.0, desktop: 20.0);

  static double listItemHeight(BuildContext context) =>
      value(context, phone: 80.0, tablet: 90.0, desktop: 100.0);

  static double scale(BuildContext context) {
    final w = screenWidth(context);
    if (w >= desktopBreakpoint) return 1.2;
    if (w >= tabletBreakpoint) return 1.125;
    return 1.0;
  }

  static double fontSize(BuildContext context, {required double phone}) =>
      phone * scale(context);

  static double iconSize(BuildContext context, {required double phone}) =>
      phone * scale(context);

  static double radius(BuildContext context, {required double phone}) =>
      phone * (1.0 + (scale(context) - 1.0) * 0.5);

  static double boxSize(BuildContext context, {required double phone}) =>
      phone * scale(context);

  static int gridColumns(
    BuildContext context, {
    int phone = 3,
    int? tablet,
    int? desktop,
  }) {
    final w = screenWidth(context);
    if (w >= desktopBreakpoint) return desktop ?? tablet ?? phone;
    if (w >= tabletBreakpoint) return tablet ?? phone;
    return phone;
  }

  static TextStyle textStyle(
    TextStyle? style, {
    int maxLines = 2,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    return (style ?? const TextStyle()).copyWith(overflow: overflow);
  }

  static Widget text(
    String data, {
    TextStyle? style,
    int maxLines = 2,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextAlign? textAlign,
  }) {
    return Text(
      data,
      style: (style ?? const TextStyle()).copyWith(overflow: overflow),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: true,
    );
  }
}
