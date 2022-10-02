import 'package:meta/meta.dart';

class RoleAdd {
  final String name;
  final String description;
  final bool isActive;

  RoleAdd({
    @required this.name,
    @required this.description,
    @required this.isActive,
  });

  factory RoleAdd.fromJson(Map<String, dynamic> json) {
    return RoleAdd(
      name: json['name'],
      description: json['description'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'isActive': isActive,
    };
  }

  static RoleAdd fromJsonModel(Map<String, dynamic> json) => RoleAdd.fromJson(json);
}
