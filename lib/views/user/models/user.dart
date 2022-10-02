import 'package:meta/meta.dart';

class User {
  final String userId;
  final String userName;
  final String fullName;
  final String email;
  final String department;
  final String designation;
  bool isActive;
  bool isLocked;
  bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    @required this.userId,
    @required this.userName,
    @required this.fullName,
    @required this.email,
    @required this.department,
    @required this.designation,
    @required this.isActive,
    @required this.isLocked,
    @required this.isDeleted,
    @required this.createdAt,
    @required this.updatedAt,
  });

  bool get isAdmin => userName == 'admin';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      fullName: json['fullName'],
      email: json['email'],
      department: json['department'],
      designation: json['designation'],
      isActive: json['isActive'],
      isLocked: json['isLocked'],
      isDeleted: json['isDeleted'],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    );
  }

  static User fromJsonModel(Map<String, dynamic> json) => User.fromJson(json);
}
