import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../services/navigator_service.dart';
import '../locator.dart';
import '../logger.dart';

abstract class BaseViewModel extends ChangeNotifier {
  final navigatorService = locator<NavigatorService>();

  final String _title;
  bool _isLoading;
  Logger log;
  bool _isDisposed = false;

  BaseViewModel({
    bool isLoading = false,
    String title,
  })  : _isLoading = isLoading,
        _title = title {
    log = getLogger(title ?? runtimeType.toString());
  }

  bool get isLoading => _isLoading;
  bool get isDisposed => _isDisposed;
  String get title => _title ?? runtimeType.toString();

  set isLoading(bool isLoading) {
    log.i(
      'isLoading: '
      '$title is entering '
      '${isLoading ? 'isLoading' : 'free'} state',
    );
    _isLoading = isLoading;
    notifyListeners();
  }

  void showSucessMessage({
    @required BuildContext context,
    @required String message,
    Function callback,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
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
    if (callback != null) {
      callback();
    }
  }

  void showErrorMessage({
    @required BuildContext context,
    @required String message,
    Function callback,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
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

  void navigateToPage(String route, {Object arguments}) {
    navigatorService.navigateToPageWithReplacementNamed(route, arguments: arguments);
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    } else {
      log.w(
        'notifyListeners: Notify listeners called after '
        '${title ?? runtimeType.toString()} has been disposed',
      );
    }
  }

  @override
  void dispose() {
    log.i('dispose');
    _isDisposed = true;
    super.dispose();
  }
}
