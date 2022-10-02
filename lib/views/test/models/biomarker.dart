import 'package:meta/meta.dart';

class Biomarker {
  final double concentrationA;
  final double biomarkerAQc1PgMl;
  final double biomarkerAQc2PgMl;
  final double concentrationC;
  final double biomarkerCQc1PgMl;
  final double biomarkerCQc2PgMl;
  final double concentrationG;
  final double biomarkerGQc1PgMl;
  final double biomarkerGQc2PgMl;
  final double concentrationP;
  final double biomarkerPQc1PgMl;
  final double biomarkerPQc2PgMl;
  final double concentrationS;
  final double biomarkerSQc1PgMl;
  final double biomarkerSQc2PgMl;

  Biomarker({
    @required this.concentrationA,
    this.biomarkerAQc1PgMl,
    this.biomarkerAQc2PgMl,
    @required this.concentrationC,
    this.biomarkerCQc1PgMl,
    this.biomarkerCQc2PgMl,
    @required this.concentrationG,
    this.biomarkerGQc1PgMl,
    this.biomarkerGQc2PgMl,
    @required this.concentrationP,
    this.biomarkerPQc1PgMl,
    this.biomarkerPQc2PgMl,
    @required this.concentrationS,
    this.biomarkerSQc1PgMl,
    this.biomarkerSQc2PgMl,
  });

  Map<String, dynamic> toJson() {
    return {
      'concentrationA': concentrationA,
      'biomarkerAQc1PgMl': biomarkerAQc1PgMl,
      'biomarkerAQc2PgMl': biomarkerAQc2PgMl,
      'concentrationC': concentrationC,
      'biomarkerCQc1PgMl': biomarkerCQc1PgMl,
      'biomarkerCQc2PgMl': biomarkerCQc2PgMl,
      'concentrationG': concentrationG,
      'biomarkerGQc1PgMl': biomarkerGQc1PgMl,
      'biomarkerGQc2PgMl': biomarkerGQc2PgMl,
      'concentrationP': concentrationP,
      'biomarkerPQc1PgMl': biomarkerPQc1PgMl,
      'biomarkerPQc2PgMl': biomarkerPQc2PgMl,
      'concentrationS': concentrationS,
      'biomarkerSQc1PgMl': biomarkerSQc1PgMl,
      'biomarkerSQc2PgMl': biomarkerSQc2PgMl,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory Biomarker.fromJson(Map<String, dynamic> json) {
    return Biomarker(
      concentrationA: json['concentrationA'].toDouble(),
      biomarkerAQc1PgMl: json['biomarkerAQc1PgMl']?.toDouble(),
      biomarkerAQc2PgMl: json['biomarkerAQc2PgMl']?.toDouble(),
      concentrationC: json['concentrationC'].toDouble(),
      biomarkerCQc1PgMl: json['biomarkerCQc1PgMl']?.toDouble(),
      biomarkerCQc2PgMl: json['biomarkerCQc2PgMl']?.toDouble(),
      concentrationG: json['concentrationG'].toDouble(),
      biomarkerGQc1PgMl: json['biomarkerGQc1PgMl']?.toDouble(),
      biomarkerGQc2PgMl: json['biomarkerGQc2PgMl']?.toDouble(),
      concentrationP: json['concentrationP'].toDouble(),
      biomarkerPQc1PgMl: json['biomarkerPQc1PgMl']?.toDouble(),
      biomarkerPQc2PgMl: json['biomarkerPQc2PgMl']?.toDouble(),
      concentrationS: json['concentrationS'].toDouble(),
      biomarkerSQc1PgMl: json['biomarkerSQc1PgMl']?.toDouble(),
      biomarkerSQc2PgMl: json['biomarkerSQc2PgMl']?.toDouble(),
    );
  }

  factory Biomarker.fromMap(Map<String, dynamic> map) {
    return Biomarker(
      concentrationA: map['concentrationA'],
      biomarkerAQc1PgMl: map['biomarkerAQc1PgMl'],
      biomarkerAQc2PgMl: map['biomarkerAQc2PgMl'],
      concentrationC: map['concentrationC'],
      biomarkerCQc1PgMl: map['biomarkerCQc1PgMl'],
      biomarkerCQc2PgMl: map['biomarkerCQc2PgMl'],
      concentrationG: map['concentrationG'],
      biomarkerGQc1PgMl: map['biomarkerGQc1PgMl'],
      biomarkerGQc2PgMl: map['biomarkerGQc2PgMl'],
      concentrationP: map['concentrationP'],
      biomarkerPQc1PgMl: map['biomarkerPQc1PgMl'],
      biomarkerPQc2PgMl: map['biomarkerPQc2PgMl'],
      concentrationS: map['concentrationS'],
      biomarkerSQc1PgMl: map['biomarkerSQc1PgMl'],
      biomarkerSQc2PgMl: map['biomarkerSQc2PgMl'],
    );
  }
}
