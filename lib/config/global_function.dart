import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_carosel_slider/config/theme.dart';
import 'package:hive/hive.dart';

class GlobalFunction {


  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void showCustomSnackbar({
    required String message,
    required bool isSuccess,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      dismissDirection: DismissDirection.startToEnd,
      backgroundColor: isSuccess
          ? colors(navigatorKey.currentState!.context).primaryColor
          : colors(navigatorKey.currentState!.context).errorColor,
      content: Text(message),
    );
    ScaffoldMessenger.of(navigatorKey.currentState!.context)
        .showSnackBar(snackBar);
  }



 

}
