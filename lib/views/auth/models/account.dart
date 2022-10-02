import 'package:meta/meta.dart';

class Account {
  final String userName;
  final String email;
  final String fullName;
  final String department;
  final String designation;
  final String password;
  final int securityQuestion1;
  final String securityAnswer1;
  final int securityQuestion2;
  final String securityAnswer2;

  Account({
    @required this.userName,
    @required this.fullName,
    @required this.department,
    @required this.designation,
    @required this.email,
    @required this.password,
    @required this.securityQuestion1,
    @required this.securityAnswer1,
    @required this.securityQuestion2,
    @required this.securityAnswer2,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      userName: json['userName'],
      fullName: json['fullName'],
      department: json['department'],
      designation: json['designation'],
      email: json['email'],
      password: json['password'],
      securityQuestion1: json['securityQuestion1'],
      securityAnswer1: json['securityAnswer1'],
      securityQuestion2: json['securityQuestion2'],
      securityAnswer2: json['securityAnswer2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'fullName': fullName,
      'department': department,
      'designation': designation,
      'email': email,
      'password': password,
      'securityQuestion1': securityQuestion1,
      'securityAnswer1': securityAnswer1,
      'securityQuestion2': securityQuestion2,
      'securityAnswer2': securityAnswer2,
    };
  }
}
