import 'package:meta/meta.dart';

class Patient {
  final int id;
  final String identifier;
  final DateTime dateOfBirth;
  final String gender;
  final int smokingStatus;

  Patient({
    this.id,
    @required this.identifier,
    @required this.dateOfBirth,
    this.gender,
    this.smokingStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'identifier': identifier,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'smokingStatus': smokingStatus,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'identifier': identifier,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'smokingStatus': smokingStatus,
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      identifier: json['identifier'],
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.tryParse(json['dateOfBirth']) : null,
      gender: json['gender'],
      smokingStatus: json['smokingStatus'],
    );
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'],
      identifier: map['identifier'],
      dateOfBirth: map['dateOfBirth'],
      gender: map['gender'],
      smokingStatus: map['smokingStatus'],
    );
  }
}
