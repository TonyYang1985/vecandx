import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../services/common_service.dart';
import '../../../widgets/loading_widget.dart';
import '../../../core/locator.dart';
import '../../../core/services/navigator_service.dart';

void askPasswordDialog({
  String title = 'Verify Password',
  String subTitle = 'Enter your password to continue.',
  @required String message,
  @required Function onConfirmed,
}) {
  final navigatorService = locator<NavigatorService>();
  final commonService = locator<CommonService>();
  final passwordForm = fb.group({
    'password': FormControl<String>(
      validators: [Validators.required],
    ),
  });

  var isLoading = false;

  void verifyPassword(Map<String, dynamic> values) async {
    isLoading = true;
    final password = values['password'] as String;
    commonService.verifyPassword(password).then((apiResponse) {
      if (apiResponse.success && apiResponse.result) {
        if (onConfirmed != null) onConfirmed();
      } else {
        navigatorService.showErrorMessage(message: apiResponse.message);
      }
      navigatorService.pop();
    }).whenComplete(() => isLoading = false);
  }

  Future.delayed(
    Duration(),
    () => showDialog<void>(
      context: navigatorService.navigatorKey.currentState.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return ReactiveFormBuilder(
          form: () => passwordForm,
          builder: (context, form, child) {
            return AlertDialog(
              title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(minWidth: 350, maxWidth: 450),
                  child: ListBody(
                    children: <Widget>[
                      Text(subTitle),
                      SizedBox(height: 10),
                      Text(message),
                      SizedBox(height: 15),
                      Container(
                        child: ReactiveTextField(
                          formControlName: 'password',
                          obscureText: true,
                          validationMessages: (control) => {'required': 'Password is required'},
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Password*',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                SizedBox(
                  width: 120,
                  height: 35,
                  child: OutlinedButton(
                    onPressed: !isLoading ? () => verifyPassword(form.value) : null,
                    child: isLoading ? LoadingWidget(size: 20, stroke: 2) : Text('Yes'),
                  ),
                ),
                SizedBox(
                  width: 120,
                  height: 35,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('No'),
                  ),
                ),
              ],
            );
          },
        );
      },
    ),
  );
}
