import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/models/permission.dart';
import '../../../core/models/dropdown_item.dart';
import '../../../core/constants/route_constant.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/locator.dart';
import '../../module/services/module_service.dart';
import '../../role/services/role_service.dart';
import '../models/role_module.dart';
import '../models/role_module_add.dart';
import '../services/role_module_service.dart';

class RoleModuleAssignViewModel extends BaseViewModel {
  final roleModuleService = locator<RoleModuleService>();
  final roleService = locator<RoleService>();
  final moduleService = locator<ModuleService>();

  final FormGroup form = fb.group({
    'roleId': FormControl<String>(
      validators: [Validators.required],
    ),
  });

  RoleModule _assignment;
  List<DropdownItem<dynamic>> _roleDropdownItems = [];
  List<ModulePermissionAdd> _modulePermissions = [];

  RoleModule get assignment => _assignment;
  set assignment(RoleModule value) {
    _assignment = value;
    notifyListeners();
  }

  List<DropdownItem<dynamic>> get roleDropdownItems => _roleDropdownItems;
  set roleDropdownItems(List<DropdownItem<dynamic>> value) {
    _roleDropdownItems = value;
    notifyListeners();
  }

  List<ModulePermissionAdd> get modulePermissions => _modulePermissions;
  set modulePermissions(List<ModulePermissionAdd> value) {
    _modulePermissions = value;
    notifyListeners();
  }

  void initialise({RoleModule assignment}) {
    notifyListeners();
    if (assignment != null) {
      this.assignment = assignment;
      form.patchValue({'roleId': assignment.roleId});
    }

    _getRoleDrodpdownList();
    _getModules();
  }

  void _getRoleDrodpdownList() {
    roleService.getRoleDropdownList().then((roles) {
      roleDropdownItems = roles;
    });
  }

  void _getModules() {
    moduleService.getModules().then((modules) {
      modulePermissions = modules.map((module) {
        return ModulePermissionAdd(
          moduleId: module.id,
          menuName: module.menuName,
          permissionTypes: [],
        );
      }).toList();

      if (assignment != null) {
        getRoleModuleAssignments(assignment.roleId);
      }
    });
  }

  void getRoleModuleAssignments(String roleId) {
    roleModuleService.getRoleModuleAssignments(roleId).then((assignment) {
      // this.assignment = assignment;
      modulePermissions = modulePermissions.map((module) {
        final assignedModule =
            assignment.modules.firstWhere((item) => item.moduleId == module.moduleId, orElse: () => null);
        return ModulePermissionAdd(
          menuName: module.menuName,
          moduleId: module.moduleId,
          permissionTypes: assignedModule?.permissions ?? [],
        );
      }).toList();
    });
  }

  void allowAllPermissions(ModulePermissionAdd module, bool checked) {
    if (checked) {
      module.permissionTypes = [...Permission.values.where((item) => item != Permission.None).toList()];
    } else {
      module.permissionTypes = [];
    }
    notifyListeners();
  }

  bool isAllPermissionAllowed(ModulePermissionAdd module) {
    return Permission.values
        .where((item) => item != Permission.None)
        .every((item) => module.permissionTypes.contains(item));
  }

  void allowPermission(ModulePermissionAdd module, Permission permissionType, bool checked) {
    final allowed = isPermissionAllowed(module, permissionType);
    if (allowed && !checked) {
      module.permissionTypes = module.permissionTypes.where((item) => item != permissionType).toList();
    } else if (!allowed && checked) {
      module.permissionTypes.add(permissionType);
      module.permissionTypes = [...module.permissionTypes];
    }
    notifyListeners();
  }

  bool isPermissionAllowed(ModulePermissionAdd module, Permission permissionType) {
    return module.permissionTypes.any((item) => permissionType == item);
  }

  void addRoleModuleAssignment() {
    isLoading = true;
    if (form.valid) {
      final roleModule = RoleModuleAdd(
        roleId: form.control('roleId').value,
        modulePermissions: modulePermissions.where((module) => module.permissionTypes.isNotEmpty).toList(),
      );

      roleModuleService.assignRoleModule(roleModule).then((result) {
        if (result != null) {
          navigatorService.showSucessMessage(message: 'The role modules assigned successfully!');
          navigateToListPage();
        }
      }).whenComplete(() => isLoading = false);
    }
  }

  void navigateToListPage() {
    navigateToPage(Routes.roleModuleAssignment);
  }
}
