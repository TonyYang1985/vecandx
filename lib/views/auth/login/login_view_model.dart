import 'package:flutter/material.dart';

import '../../../core/locator.dart';
import '../../../core/services/navigator_service.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/constants/route_constant.dart';
import '../models/login.dart';
import '../services/auth_service.dart';

class LoginViewModel extends BaseViewModel {
  final navigatorService = locator<NavigatorService>();
  final authService = locator<AuthService>();

  bool _isLoggedIn = false;
  bool _hidePassword = true;
  bool _formSubmitted = false;

  void initialise() {
    isLoggedIn = authService.isLoggedIn;
    if (_isLoggedIn) {
      navigatorService.navigateToPageWithReplacementNamed(Routes.dashboard);
    }
  }

  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  bool get hidePassword => _hidePassword;
  set hidePassword(bool value) {
    _hidePassword = value;
    notifyListeners();
  }

  bool get formSubmitted => _formSubmitted;
  set formSubmitted(bool value) {
    _formSubmitted = value;
    notifyListeners();
  }

  void onLogin(Login login, BuildContext context) {
    formSubmitted = true;
    isLoading = true;
    authService.authenticate(login).then((apiResponse) {
      if (apiResponse == null) {
        navigatorService.showErrorMessage(message: 'Authentication failed, Invalid credential!');
      } else if (apiResponse.success && apiResponse.result != null) {
        final authUser = apiResponse.result;
        if (authUser != null) {
          isLoggedIn = true;
          navigatorService.navigateToPageWithReplacementNamed(Routes.dashboard);
        }
      } else if (!apiResponse.success) {
        navigatorService.showErrorMessage(message: apiResponse.message);
      } else {
        navigatorService.showErrorMessage(message: 'Authentication failed, Invalid credential!');
      }
    }).whenComplete(() => isLoading = false);
  }

  void navigateToResetPasswordChallenge() {
    navigatorService.navigateToPageNamed(Routes.resetPasswordChallenge);
  }

  void navigateToCreateAccount() {
    navigatorService.navigateToPageNamed(Routes.createAccount);
  }
}
