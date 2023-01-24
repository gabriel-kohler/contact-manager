import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  ToastUtil._();

  @visibleForTesting
  static void mock(ToastUtil instance) {
    _instance = instance;
  }

  static ToastUtil? _instance;

  static ToastUtil get instance {
    _instance ??= ToastUtil._();
    return _instance!;
  }

  showToast({
    required String message,
    String? title,
    toastLength = Toast.LENGTH_LONG,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
  }) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  DateTime? lastShownToastDate;

  showToastDebounce({
    required String message,
    String? title,
    Duration debounce = Duration.zero,
    toastLength: Toast.LENGTH_LONG,
  }) {
    final now = DateTime.now();
    if (lastShownToastDate == null ||
        lastShownToastDate!.millisecondsSinceEpoch + debounce.inMilliseconds <=
            now.millisecondsSinceEpoch) {
      lastShownToastDate = now;
      showToast(
        message: message,
        title: title,
        toastLength: toastLength,
      );
    }
  }
}
