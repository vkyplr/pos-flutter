import 'package:flutter/material.dart';
import 'package:inventory/ui/app_colors.dart';
import 'package:inventory/ui/text_styles.dart';

class CommonUtil {
  static void showSnackBar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: isError ? AppColors.red : AppColors.green,
        content: Text(
          message,
          style: TextStyles.body5().copyWith(color: Colors.white),
        )));
  }
}
