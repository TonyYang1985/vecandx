import 'package:meta/meta.dart';

import 'permission.dart';

class AppModule {
  final int moduleId;
  final String moduleName;
  final String menuName;
  final String route;
  final int order;
  final String icon;
  final List<Permission> permissions;

  AppModule({
    @required this.moduleId,
    @required this.moduleName,
    @required this.menuName,
    @required this.route,
    @required this.order,
    @required this.icon,
    @required this.permissions,
  });

  factory AppModule.fromJson(Map<String, dynamic> json) {
    return AppModule(
      moduleId: json['moduleId'],
      moduleName: json['moduleName'],
      menuName: json['menuName'],
      route: json['route'],
      order: json['order'],
      icon: json['icon'],
      permissions: List<Permission>.from(json['permissionTypes'].map((x) => Permission.values[x])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'moduleId': moduleId,
      'moduleName': moduleName,
      'menuName': menuName,
      'route': route,
      'order': order,
      'icon': icon,
      'permissionTypes': List<dynamic>.from(permissions.map((x) => x.index)),
    };
  }
}
