import 'package:meta/meta.dart';

class PasswordResetToken {
  final String userName;
  final String token;

  PasswordResetToken({
    @required this.userName,
    @required this.token,
  });

  factory PasswordResetToken.fromJson(Map<String, dynamic> json) {
    return PasswordResetToken(
      userName: json['userName'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'token': token,
    };
  }

  static PasswordResetToken fromJsonModel(Map<String, dynamic> json) => PasswordResetToken.fromJson(json);
}
