import 'package:meta/meta.dart';

class Module {
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final String menuName;
  final String name;
  final String route;
  final int order;
  final String icon;

  Module({
    @required this.isActive,
    @required this.isDeleted,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.id,
    @required this.menuName,
    @required this.name,
    @required this.route,
    @required this.order,
    @required this.icon,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      isActive: json['isActive'],
      isDeleted: json['isDeleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      id: json['id'],
      menuName: json['menuName'],
      name: json['name'],
      route: json['route'],
      order: json['order'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'id': id,
      'menuName': menuName,
      'name': name,
      'route': route,
      'order': order,
      'icon': icon,
    };
  }

  static Module fromJsonModel(Map<String, dynamic> json) => Module.fromJson(json);
}
