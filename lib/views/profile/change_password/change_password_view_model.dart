import '../../../core/locator.dart';
import '../../../core/services/navigator_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/constants/route_constant.dart';
import '../models/password_change.dart';
import '../services/profile_service.dart';

class ChangePasswordViewModel extends BaseViewModel {
  final navigatorService = locator<NavigatorService>();
  final profileService = locator<ProfileService>();
  final storageService = locator<StorageService>();

  bool _hidePassword = true;
  bool _formSubmitted = false;

  void initialise() {}

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

  void changePassword(PasswordChange passwordReset) {
    formSubmitted = true;
    isLoading = true;
    passwordReset.userName = storageService.authUser?.userName;
    profileService.changePassword(passwordReset).then((apiResponse) {
      if (apiResponse.success && apiResponse.result) {
        storageService.removeAuthUser();
        navigatorService.showSucessMessage(message: 'Password changed successfully, login again!');
        navigatorService.navigateToUntilPageWithReplacementNamed(Routes.login);
      } else {
        navigatorService.showErrorMessage(message: apiResponse.message);
      }
    }).whenComplete(() => isLoading = false);
  }
}
