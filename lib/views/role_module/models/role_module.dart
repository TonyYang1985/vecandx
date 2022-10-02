import 'package:meta/meta.dart';

import '../../../core/models/app_module.dart';

class RoleModule {
  final String roleId;
  final String roleName;
  final List<AppModule> modules;

  RoleModule({
    @required this.roleId,
    @required this.roleName,
    @required this.modules,
  });

  String get allModules {
    return modules.map((module) => module.menuName).join(',');
  }

  List<String> get allModulList {
    return modules.map((module) => module.menuName).toList();
  }

  factory RoleModule.fromJson(Map<String, dynamic> json) {
    return RoleModule(
      roleId: json['roleId'],
      roleName: json['roleName'],
      modules: List<AppModule>.from(json['modulePermissions'].map((module) => AppModule.fromJson(module))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roleId': roleId,
      'roleName': roleName,
      'modulePermissions': List<dynamic>.from(modules.map((module) => module.toJson())),
    };
  }

  static RoleModule fromJsonModel(Map<String, dynamic> json) => RoleModule.fromJson(json);
}
