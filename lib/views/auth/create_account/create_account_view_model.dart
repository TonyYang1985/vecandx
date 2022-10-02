import 'package:flutter/material.dart';

import '../../../core/locator.dart';
import '../../../core/services/navigator_service.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/constants/core_data_constant.dart';
import '../services/auth_service.dart';
import '../models/account.dart';

class CreateAccountViewModel extends BaseViewModel {
  final navigatorService = locator<NavigatorService>();
  final authService = locator<AuthService>();
  final List<DropdownMenuItem<int>> _securityQuestions = CoreData.securityQuestions;

  List<DropdownMenuItem<int>> _filteredSecurityQuestions = [];
  bool _accountCreated = false;
  bool _hidePassword = true;
  bool _formSubmitted = false;

  void initialise() {
    notifyListeners();
  }

  List<DropdownMenuItem<int>> get securityQuestions => _securityQuestions;

  bool get accountCreated => _accountCreated;
  set accountCreated(bool value) {
    _accountCreated = value;
    notifyListeners();
  }

  List<DropdownMenuItem<int>> get filteredSecurityQuestions => _filteredSecurityQuestions;
  set filteredSecurityQuestions(List<DropdownMenuItem<int>> value) {
    _filteredSecurityQuestions = value;
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

  void filterSecurityQuestions(int questionNo) {
    filteredSecurityQuestions = _securityQuestions.where((item) => item.value != questionNo).toList();
  }

  void onCreateAccount(Account account, BuildContext context) {
    formSubmitted = true;
    isLoading = true;

    authService.createAccount(account).then((response) {
      if (response != null) {
        if (response.success) {
          accountCreated = true;
          showSucessMessage(
            context: context,
            message: 'Account has been created.',
            callback: () => Future.delayed(
              Duration(seconds: 3),
              () => navigatorService.pop(),
            ),
          );
        } else {
          showErrorMessage(context: context, message: response.message);
        }
      } else {
        showErrorMessage(context: context, message: 'Failed created account, try again.');
      }
    }).whenComplete(() {
      isLoading = false;
    });
  }
}
