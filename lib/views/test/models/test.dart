import 'package:meta/meta.dart';

class Test {
  final int id;
  final String sampleNumber;
  final DateTime sampleCollectionDate;
  final String departmentOrClinic;
  final String doctorName;
  final String elisaKitLotNumber;
  final DateTime dateOfTest;
  final double riskScore;
  final bool isSubmitted;
  bool isInvalid;
  final String createdBy;
  final String updatedBy;

  Test({
    this.id,
    @required this.sampleNumber,
    @required this.sampleCollectionDate,
    @required this.doctorName,
    @required this.elisaKitLotNumber,
    @required this.dateOfTest,
    @required this.riskScore,
    this.departmentOrClinic,
    @required this.isSubmitted,
    @required this.isInvalid,
    this.createdBy,
    this.updatedBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sampleNumber': sampleNumber,
      'sampleCollectionDate': sampleCollectionDate?.toIso8601String(),
      'doctorName': doctorName,
      'elisaKitLotNumber': elisaKitLotNumber,
      'dateOfTest': dateOfTest?.toIso8601String(),
      'riskScore': riskScore,
      'departmentOrClinic': departmentOrClinic,
      'isSubmitted': isSubmitted,
      'isInvalid': isInvalid,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sampleNumber': sampleNumber,
      'sampleCollectionDate': sampleCollectionDate,
      'doctorName': doctorName,
      'elisaKitLotNumber': elisaKitLotNumber,
      'dateOfTest': dateOfTest,
      'riskScore': riskScore,
      'departmentOrClinic': departmentOrClinic,
      'isSubmitted': isSubmitted,
      'isInvalid': isInvalid,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
    };
  }

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['id'],
      sampleNumber: json['sampleNumber'],
      sampleCollectionDate:
          json['sampleCollectionDate'] != null ? DateTime.tryParse(json['sampleCollectionDate']) : null,
      departmentOrClinic: json['departmentOrClinic'],
      doctorName: json['doctorName'],
      elisaKitLotNumber: json['elisaKitLotNumber'],
      dateOfTest: json['dateOfTest'] != null ? DateTime.tryParse(json['dateOfTest']) : null,
      riskScore: json['riskScore'] is int ? double.parse(json['riskScore'].toString()) : json['riskScore'],
      isSubmitted: json['isSubmitted'],
      isInvalid: json['isInvalid'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
    );
  }

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      id: map['id'],
      sampleNumber: map['sampleNumber'],
      sampleCollectionDate: map['sampleCollectionDate'],
      departmentOrClinic: map['departmentOrClinic'],
      doctorName: map['doctorName'],
      elisaKitLotNumber: map['elisaKitLotNumber'],
      dateOfTest: map['dateOfTest'],
      riskScore: map['riskScore'] is int ? double.parse(map['riskScore'].toString()) : map['riskScore'],
      isSubmitted: map['isSubmitted'],
      isInvalid: map['isInvalid'],
      createdBy: map['createdBy'],
      updatedBy: map['updatedBy'],
    );
  }
}
