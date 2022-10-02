import '../../../core/locator.dart';
import '../../../core/services/navigator_service.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/constants/route_constant.dart';
import '../models/password_reset_token.dart';
import '../models/password_reset.dart';
import '../services/auth_service.dart';

class ResetPasswordViewModel extends BaseViewModel {
  final navigatorService = locator<NavigatorService>();
  final authService = locator<AuthService>();

  PasswordResetToken _passwordResetToken;
  bool _hidePassword = true;
  bool _formSubmitted = false;

  void initialise(PasswordResetToken passwordResetToken) {
    this.passwordResetToken = passwordResetToken;
  }

  PasswordResetToken get passwordResetToken => _passwordResetToken;
  set passwordResetToken(PasswordResetToken value) {
    _passwordResetToken = value;
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

  void resetPassword(PasswordReset passwordReset) {
    formSubmitted = true;
    isLoading = true;
    authService.resetPassword(passwordReset).then((apiResponse) {
      if (apiResponse.success && apiResponse.result) {
        navigatorService.navigateToUntilPageWithReplacementNamed(Routes.login);
      } else {
        navigatorService.showErrorMessage(message: apiResponse.message);
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
