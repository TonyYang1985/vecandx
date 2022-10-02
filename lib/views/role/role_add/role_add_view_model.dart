import '../../../core/constants/route_constant.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/locator.dart';
import '../../../core/services/navigator_service.dart';
import '../models/role_add.dart';
import '../services/role_service.dart';

class RoleAddViewModel extends BaseViewModel {
  final navigatorService = locator<NavigatorService>();
  final roleService = locator<RoleService>();

  void initialise() {
    notifyListeners();
  }

  void addRole(RoleAdd role, {Function onAdded}) {
    isLoading = true;
    roleService.addRole(role).then((result) {
      if (result != null) {
        navigatorService.showSucessMessage(message: 'The role is added successfully!');
        navigateToListPage();
      }
      if (onAdded != null) {
        onAdded();
      }
    }).whenComplete(() => isLoading = false);
  }

  void navigateToListPage() {
    navigatorService.navigateToPageWithReplacementNamed(Routes.roleList);
  }
}
