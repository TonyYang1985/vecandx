import 'package:meta/meta.dart';

import './patient.dart';
import './test.dart';
import './biomarker.dart';

class PatientTest {
  final Patient patient;
  final Test test;
  final Biomarker biomarker;

  PatientTest({
    @required this.patient,
    @required this.test,
    @required this.biomarker,
  });

  Map<String, dynamic> toMap() {
    return {
      'patient': patient.toMap(),
      'test': test.toMap(),
      'biomarker': biomarker.toJson(),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'patient': patient.toJson(),
      'test': test.toJson(),
      'biomarker': biomarker.toJson(),
    };
  }

  factory PatientTest.fromJson(Map<String, dynamic> json) {
    return PatientTest(
      patient: Patient.fromJson(json['patient']),
      test: Test.fromJson(json['test']),
      biomarker: Biomarker.fromJson(json['biomarker']),
    );
  }

  factory PatientTest.fromMap(Map<String, dynamic> map) {
    return PatientTest(
      patient: Patient.fromMap(map['patient']),
      test: Test.fromMap(map['test']),
      biomarker: Biomarker.fromMap(map['biomarker']),
    );
  }

  static PatientTest fromJsonModel(Map<String, dynamic> json) => PatientTest.fromJson(json);
}
