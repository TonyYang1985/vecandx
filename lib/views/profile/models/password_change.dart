import 'package:meta/meta.dart';

class PasswordChange {
  String userName;
  final String currentPassword;
  final String newPassword;

  PasswordChange({
    @required this.userName,
    @required this.currentPassword,
    @required this.newPassword,
  });

  factory PasswordChange.fromJson(Map<String, dynamic> json) {
    return PasswordChange(
      userName: json['userName'],
      currentPassword: json['currentPassword'],
      newPassword: json['newPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
  }
}
