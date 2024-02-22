import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

final class CommonWidgets {
  showDialog(BuildContext context, message) {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          // title: const Text("title"),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("Ok"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      );
    } else {
      messangerKey.currentState!.showSnackBar(SnackBar(
        content: Text(message),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
}
