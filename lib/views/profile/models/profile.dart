import 'package:meta/meta.dart';

class Profile {
  final String userName;
  final String fullName;
  final String department;
  final String designation;
  final String email;
  final int securityQuestion1;
  final String securityAnswer1;
  final int securityQuestion2;
  final String securityAnswer2;

  Profile({
    @required this.userName,
    this.fullName,
    this.department,
    this.designation,
    @required this.email,
    this.securityQuestion1,
    this.securityAnswer1,
    this.securityQuestion2,
    this.securityAnswer2,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userName: json['userName'],
      fullName: json['fullName'],
      department: json['department'],
      designation: json['designation'],
      email: json['email'],
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
      'securityQuestion1': securityQuestion1,
      'securityAnswer1': securityAnswer1,
      'securityQuestion2': securityQuestion2,
      'securityAnswer2': securityAnswer2,
    };
  }

  static Profile fromJsonModel(Map<String, dynamic> json) => Profile.fromJson(json);
}
