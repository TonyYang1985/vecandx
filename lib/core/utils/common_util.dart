import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class CommonUtil {
  static Future<void> showConfirmationDialog(
    BuildContext context, {
    String title = 'Confirmation',
    String subTitle = 'Your unsaved work will be lost.',
    String confirmationMessage = 'Are you sure you want to close the application?',
    Function onConfirmed,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(subTitle),
                Text(confirmationMessage),
              ],
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: 120,
              height: 35,
              child: OutlinedButton(
                onPressed: onConfirmed ?? () => appWindow.close(),
                child: Text('Yes'),
              ),
            ),
            SizedBox(
              width: 120,
              height: 35,
              child: ElevatedButton(
            style: ElevatedButton.styleFrom(
foregroundColor: Colors.white,
backgroundColor: Theme.of(context).primaryColor
),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'),
              ),
            ),
          ],
        );
      },
    );
  }
}
