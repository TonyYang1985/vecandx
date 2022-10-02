import 'package:meta/meta.dart';

class RoleEdit {
  final String id;
  final String name;
  final String description;
  final bool isActive;

  RoleEdit({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.isActive,
  });

  factory RoleEdit.fromJson(Map<String, dynamic> json) {
    return RoleEdit(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isActive': isActive,
    };
  }

  static RoleEdit fromJsonModel(Map<String, dynamic> json) => RoleEdit.fromJson(json);
}
