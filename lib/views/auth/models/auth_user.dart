import 'package:meta/meta.dart';
import 'package:vecandx/core/models/app_module.dart';

class AuthUser {
  final String userId;
  final String userName;
  final String roleId;
  final String roleName;
  final String fullName;
  final String email;
  final String department;
  final String designation;
  final String accessToken;
  final DateTime accessTokenExpiry;
  final String refreshToken;
  final List<AppModule> modules;

  AuthUser({
    @required this.userId,
    @required this.userName,
    @required this.roleId,
    @required this.roleName,
    @required this.fullName,
    @required this.email,
    @required this.department,
    @required this.designation,
    @required this.accessToken,
    @required this.accessTokenExpiry,
    this.refreshToken,
    @required this.modules,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      userId: json['userId'],
      userName: json['userName'],
      roleId: json['roleId'],
      roleName: json['roleName'],
      fullName: json['fullName'],
      email: json['email'],
      department: json['department'],
      designation: json['designation'],
      accessToken: json['accessToken'],
      accessTokenExpiry: DateTime.tryParse(json['accessTokenExpiry']),
      refreshToken: json['refreshToken'],
      modules: List<AppModule>.from(json['modules'].map((moduleMap) => AppModule.fromJson(moduleMap))),
    );
  }

  static AuthUser fromJsonModel(Map<String, dynamic> json) => AuthUser.fromJson(json);
}
