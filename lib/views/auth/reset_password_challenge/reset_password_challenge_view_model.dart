import 'package:flutter/material.dart';

import '../../../core/locator.dart';
import '../../../core/services/navigator_service.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/constants/route_constant.dart';
import '../../../core/constants/core_data_constant.dart';
import '../services/auth_service.dart';
import '../models/security_answer.dart';

class ResetPasswordChallengeViewModel extends BaseViewModel {
  final navigatorService = locator<NavigatorService>();
  final authService = locator<AuthService>();

  List<DropdownMenuItem<int>> _securityQuestions = [];
  bool _formSubmitted = false;
  int _retryCount = 0;

  void initialise() {
    notifyListeners();
  }

  bool get hasSecurityQuestion => securityQuestions.isNotEmpty;

  List<DropdownMenuItem<int>> get securityQuestions => _securityQuestions;
  set securityQuestions(List<DropdownMenuItem<int>> value) {
    _securityQuestions = value;
    notifyListeners();
  }

  bool get formSubmitted => _formSubmitted;
  set formSubmitted(bool value) {
    _formSubmitted = value;
    notifyListeners();
  }

  void getSecurityQuestion(String userName) {
    isLoading = true;
    authService.getSecurityQuestion(userName).then((apiResponse) {
      if (apiResponse != null) {
        if (apiResponse.success && apiResponse.result != null) {
          securityQuestions = CoreData.securityQuestions
              .where((question) => apiResponse.result.questions.contains(question.value))
              .toList();
        } else {
          navigatorService.showErrorMessage(message: apiResponse.message);
        }
      } else {
        navigatorService.showErrorMessage(message: 'Wrong username, try again.');
      }
    }).whenComplete(() => isLoading = false);
  }

  void verifySecurityAnswer(SecurityAnswer securityAnswer) {
    formSubmitted = true;
    isLoading = true;

    securityAnswer.retryCount = _retryCount;

    authService.verifySecurityAnswer(securityAnswer).then((apiResponse) {
      if (apiResponse != null) {
        if (apiResponse.success && apiResponse.result != null) {
          navigatorService.navigateToPageWithReplacementNamed(
            Routes.resetPassword,
            arguments: apiResponse.result,
          );
        } else {
          navigatorService.showErrorMessage(message: apiResponse.message);
          _retryCount += 1;
        }
      } else {
        navigatorService.showErrorMessage(message: 'Wrong security answer, try again.');
        _retryCount += 1;
      }
    }).whenComplete(() => isLoading = false);
  }

  void navigateToResetPassword() {
    navigatorService.navigateToPageNamed(Routes.resetPassword);
  }

  void navigateToCreateAccount() {
    navigatorService.navigateToPageNamed(Routes.createAccount);
  }
}
