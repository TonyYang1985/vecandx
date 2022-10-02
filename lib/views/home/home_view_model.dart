import '../../core/constants/route_constant.dart';
import '../../core/services/navigator_service.dart';
import '../../core/base/base_view_model.dart';
import '../../core/locator.dart';
import '../auth/services/auth_service.dart';

class HomeViewModel extends BaseViewModel {
  final navigatorService = locator<NavigatorService>();
  final authService = locator<AuthService>();
  bool _isLoggedIn;

  void initialise() {
    isLoggedIn = authService.isLoggedIn;
    navigateTologin();
  }

  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
    navigateTologin();
  }

  void navigateTologin() {
    Future.delayed(Duration(seconds: 1), () async {
      if (!isLoggedIn) {
        await navigatorService.navigateToPageWithReplacementNamed(Routes.login);
      } else {
        await navigatorService.navigateToPageWithReplacementNamed(Routes.addTest);
      }
    });
  }
}
