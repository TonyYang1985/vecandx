import 'package:meta/meta.dart';

class PasswordReset {
  final String userName;
  final String password;
  final String token;

  PasswordReset({
    @required this.userName,
    @required this.password,
    @required this.token,
  });

  factory PasswordReset.fromJson(Map<String, dynamic> json) {
    return PasswordReset(
      userName: json['userName'],
      password: json['password'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
      'token': token,
    };
  }
}
