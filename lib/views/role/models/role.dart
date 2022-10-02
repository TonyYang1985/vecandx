import 'package:meta/meta.dart';

class Role {
  final String id;
  final String name;
  final String description;
  bool isActive;
  bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  Role({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.isActive,
    @required this.isDeleted,
    @required this.createdAt,
    @required this.updatedAt,
  });

  bool get isAdmin => name == 'Admin';

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isActive: json['isActive'],
      isDeleted: json['isDeleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static Role fromJsonModel(Map<String, dynamic> json) => Role.fromJson(json);
}
