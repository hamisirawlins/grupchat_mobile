import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData = MediaQueryData();
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static double blockSizeHorizontal = 0.0;
  static double blockSizeVertical = 0.0;

  static double _safeAreaHorizontal = 0.0;
  static double _safeAreaVertical = 0.0;
  static double safeBlockHorizontal = 0.0;
  static double safeBlockVertical = 0.0;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

class SysUtil {
  static void launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static double calculateServiceCharge(double amount) {
    double serviceCharge = 0.0;

    if (amount <= 2000) {
      serviceCharge = 0.0;
    } else if (amount <= 2500) {
      serviceCharge = 50.0;
    } else if (amount <= 3500) {
      serviceCharge = 70.0;
    } else if (amount <= 5000) {
      serviceCharge = 100.0;
    } else if (amount <= 7500) {
      serviceCharge = 150.0;
    } else if (amount <= 10000) {
      serviceCharge = 200.0;
    } else if (amount <= 15000) {
      serviceCharge = 300.0;
    } else if (amount <= 20000) {
      serviceCharge = 400.0;
    } else if (amount <= 25000) {
      serviceCharge = 500.0;
    } else if (amount <= 30000) {
      serviceCharge = 600.0;
    } else if (amount <= 35000) {
      serviceCharge = 700.0;
    } else if (amount <= 40000) {
      serviceCharge = 800.0;
    } else if (amount <= 45000) {
      serviceCharge = 900.0;
    } else if (amount <= 50000) {
      serviceCharge = 1000.0;
    } else if (amount <= 70000) {
      serviceCharge = 1000.0;
    } else {
      serviceCharge = (amount * 0.02).floorToDouble();
    }

    return serviceCharge;
  }
}
