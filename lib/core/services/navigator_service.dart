import 'package:flutter/material.dart';

import '../../core/base/base_service.dart';

class NavigatorService extends BaseService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void showPageBottomSheet({Widget child}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: navigatorKey.currentState.context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.80,
          child: child,
        );
      },
    );
  }

  void showModalDialog({
    @required String title,
    @required String subTitle,
    @required String message,
    @required Function onConfirmed,
    Widget child,
  }) {
    Future.delayed(
      Duration(),
      () => showDialog<void>(
        context: navigatorKey.currentState.context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
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
                    if (child != null) child,
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              SizedBox(
                width: 120,
                height: 35,
                child: OutlinedButton(
                  onPressed: onConfirmed,
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
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('No'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void showConfirmationDialog({
    String title = 'Confirmation',
    @required String subTitle,
    String confirmationMessage,
    @required Function onConfirmed,
  }) {
    Future.delayed(
      Duration(),
      () => showDialog<void>(
        context: navigatorKey.currentState.context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(minWidth: 350, maxWidth: 450),
                child: ListBody(
                  children: <Widget>[
                    Text(subTitle),
                    SizedBox(height: 10),
                    if (confirmationMessage != null) Text(confirmationMessage),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              SizedBox(
                width: 120,
                height: 35,
                child: OutlinedButton(
                  onPressed: onConfirmed,
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
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('No'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void showSucessMessage({
    @required String message,
    bool pop = false,
    Function callback,
  }) {
    ScaffoldMessenger.of(navigatorKey.currentState.context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
        width: 350,
        behavior: SnackBarBehavior.floating,
      ),
    );
    if (pop) {
      Navigator.of(navigatorKey.currentState.context).pop();
    }
    if (callback != null) {
      callback();
    }
  }

  void showErrorMessage({
    @required String message,
    Function callback,
  }) {
    ScaffoldMessenger.of(navigatorKey.currentState.context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        width: 350,
        behavior: SnackBarBehavior.floating,
      ),
    );
    if (callback != null) {
      callback();
    }
  }

  Future<T> navigateToPage<T>(MaterialPageRoute<T> pageRoute) async {
    log.i('navigateToPage: pageRoute: ${pageRoute.settings.name}');
    if (navigatorKey.currentState == null) {
      log.e('navigateToPage: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState.push(pageRoute);
  }

  Future<T> navigateToPageNamed<T>(String route, {Object arguments}) async {
    log.i('navigateToPage: pageRoute: $route');
    if (navigatorKey.currentState == null) {
      log.e('navigateToPage: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState.pushNamed(route, arguments: arguments);
  }

  Future<T> navigateToPageWithReplacement<T>(MaterialPageRoute<T> pageRoute) async {
    log.i('navigateToPageWithReplacement: pageRoute: ${pageRoute.settings.name}');
    if (navigatorKey.currentState == null) {
      log.e('navigateToPageWithReplacement: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState.pushReplacement(pageRoute);
  }

  Future<T> navigateToPageWithReplacementNamed<T>(String route, {Object arguments}) async {
    log.i('navigateToPageWithReplacement: pageRoute: $route');
    if (navigatorKey.currentState == null) {
      log.e('navigateToPageWithReplacement: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState.pushReplacementNamed(route, arguments: arguments);
  }

  Future<T> navigateToUntilPageWithReplacementNamed<T>(String route) async {
    log.i('navigateToUntilPageWithReplacementNamed: pageRoute: $route');
    if (navigatorKey.currentState == null) {
      log.e('navigateToUntilPageWithReplacementNamed: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState.pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
  }

  void pop<T>([T result]) {
    log.i('goBack:');
    if (navigatorKey.currentState == null) {
      log.e('goBack: Navigator State is null');
      return;
    }
    navigatorKey.currentState.pop(result);
  }
}
