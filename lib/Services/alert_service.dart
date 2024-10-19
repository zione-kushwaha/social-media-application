import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';

class AlertService {
  AlertService() {}

  void showToast(
      {required String message,
      IconData? icon = Icons.info,
      required BuildContext context}) {
    try {
      DelightToastBar(
          autoDismiss: true,
          position: DelightSnackbarPosition.top,
          builder: (context) {
            return ToastCard(
              title: Text(message),
              leading: Icon(icon),
            );
          }).show(context);
    } catch (e) {
      print(e);
    }
  }
}
