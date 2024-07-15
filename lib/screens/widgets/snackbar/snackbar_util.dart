import 'package:f_localbrand/config/themes/custom_themes/index.dart';
import 'package:flutter/material.dart';

class SnackbarUtil {
  const SnackbarUtil({required this.message});

  final String message;

  static void showSnackbarSuccess(BuildContext context, String message,
      {double? paddingBottom}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        content: Text(
          message,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
        ),
        duration: Duration(seconds: 5),
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        margin:
            EdgeInsets.only(left: 16, right: 16, bottom: paddingBottom ?? 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static void showSnackbarError(BuildContext context, String message,
      {double? paddingBottom}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(
            message,
            style: FTextTheme.light.displaySmall
                ?.copyWith(color: Theme.of(context).colorScheme.onSecondary),
          ),
          duration: Duration(seconds: 5),
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
          margin:
              EdgeInsets.only(left: 16, right: 16, bottom: paddingBottom ?? 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    );
  }
}
