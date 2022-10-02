import 'package:meta/meta.dart';

class UserRoleAssign {
  final String userId;
  final String roleId;

  UserRoleAssign({
    @required this.userId,
    @required this.roleId,
  });

  factory UserRoleAssign.fromJson(Map<String, dynamic> json) {
    return UserRoleAssign(
      userId: json['userId'],
      roleId: json['roleId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'roleId': roleId,
    };
  }
}
