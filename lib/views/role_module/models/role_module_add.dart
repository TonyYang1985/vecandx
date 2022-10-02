import 'package:meta/meta.dart';

import '../../../core/models/permission.dart';

class RoleModuleAdd {
  final String roleId;
  final List<ModulePermissionAdd> modulePermissions;

  RoleModuleAdd({
    @required this.roleId,
    @required this.modulePermissions,
  });

  factory RoleModuleAdd.fromJson(Map<String, dynamic> json) {
    return RoleModuleAdd(
      roleId: json['roleId'],
      modulePermissions: List<ModulePermissionAdd>.from(
        json['modulePermissions'].map((modulePermission) => ModulePermissionAdd.fromJson(modulePermission)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roleId': roleId,
      'modulePermissions': List<dynamic>.from(modulePermissions.map((x) => x.toJson())),
    };
  }
}

class ModulePermissionAdd {
  final int moduleId;
  final String menuName;
  List<Permission> permissionTypes;

  ModulePermissionAdd({
    @required this.moduleId,
    @required this.menuName,
    @required this.permissionTypes,
  });

  factory ModulePermissionAdd.fromJson(Map<String, dynamic> json) {
    return ModulePermissionAdd(
      moduleId: json['moduleId'],
      menuName: json['menuName'],
      permissionTypes: List<Permission>.from(
        json['permissionTypes'].map((int type) => Permission.values[type]),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'moduleId': moduleId,
      'permissionTypes': List<int>.from(permissionTypes.map((type) => type.index)),
    };
  }
}
