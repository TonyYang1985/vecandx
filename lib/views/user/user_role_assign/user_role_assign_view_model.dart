import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/models/dropdown_item.dart';
import '../../../core/constants/route_constant.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/locator.dart';
import '../../../core/services/navigator_service.dart';
import '../../role_module/models/role_module.dart';
import '../../role_module/services/role_module_service.dart';
import '../../role/services/role_service.dart';
import '../models/user_role_assign.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserRoleAssignViewModel extends BaseViewModel {
  final navigatorService = locator<NavigatorService>();
  final userService = locator<UserService>();
  final roleService = locator<RoleService>();
  final roleModuleService = locator<RoleModuleService>();

  final FormGroup form = fb.group({
    'userId': FormControl<String>(
      validators: [Validators.required],
    ),
    'roleId': FormControl<String>(
      validators: [Validators.required],
    ),
  });

  User user;
  List<DropdownItem<dynamic>> _roleDropdownItems = [];
  RoleModule _assignment;

  List<DropdownItem<dynamic>> get roleDropdownItems => _roleDropdownItems;
  set roleDropdownItems(List<DropdownItem<dynamic>> value) {
    _roleDropdownItems = value;
    notifyListeners();
  }

  RoleModule get assignment => _assignment;
  set assignment(RoleModule value) {
    _assignment = value;
    notifyListeners();
  }

  void initialise(User user) {
    this.user = user;
    notifyListeners();

    _getRoleDrodpdownList();
    _getRole();
  }

  void _getRoleDrodpdownList() {
    roleService.getRoleDropdownList().then((roles) {
      roleDropdownItems = roles;
    });
  }

  void _getRole() {
    roleService.getRoleByUserId(user.userId).then((role) {
      form.patchValue({
        'userId': user.userId,
        'roleId': role.id,
      });
      getRoleModuleAssignments(role.id);
    });
  }

  void getRoleModuleAssignments(String roleId) {
    roleModuleService.getRoleModuleAssignments(roleId).then((assignment) {
      this.assignment = assignment;
    });
  }

  void assignUserRole() {
    if (form.valid) {
      isLoading = true;
      final userRoleAssign = UserRoleAssign.fromJson(form.value);

      userService.assignRole(userRoleAssign).then((result) {
        if (result != null) {
          navigatorService.showSucessMessage(message: 'The role is assigned successfully!');
          navigateToListPage();
        }
      }).whenComplete(() => isLoading = false);
    }
  }

  void navigateToListPage() {
    navigatorService.navigateToPageWithReplacementNamed(Routes.userList);
  }
}
