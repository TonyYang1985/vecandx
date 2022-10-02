import '../../../core/constants/route_constant.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/locator.dart';
import '../../../core/services/navigator_service.dart';
import '../services/role_service.dart';
import '../models/role.dart';
import '../models/role_edit.dart';

class RoleEditViewModel extends BaseViewModel {
  final navigatorService = locator<NavigatorService>();
  final roleService = locator<RoleService>();

  String _roleId;

  void initialise(String roleId) {
    _roleId = roleId;
    notifyListeners();
  }

  Future<Role> getRole() {
    return roleService.getRole(_roleId);
  }

  void editRole(RoleEdit role, {Function onUpdaetd}) {
    isLoading = true;
    roleService.editRole(role).then((result) {
      if (result != null) {
        navigatorService.showSucessMessage(message: 'The role is updated successfully!');
        navigateToListPage();
      }
      if (onUpdaetd != null) {
        onUpdaetd();
      }
    }).whenComplete(() => isLoading = false);
  }

  void navigateToListPage() {
    navigatorService.navigateToPageWithReplacementNamed(Routes.roleList);
  }
}
