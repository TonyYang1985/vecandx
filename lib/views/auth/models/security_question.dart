import 'package:meta/meta.dart';

class SecurityQuestion {
  final String userName;
  final List<int> questions;

  SecurityQuestion({
    @required this.userName,
    @required this.questions,
  });

  factory SecurityQuestion.fromJson(Map<String, dynamic> json) {
    return SecurityQuestion(
      userName: json['userName'],
      questions: List<int>.from(json['questions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'questions': questions,
    };
  }

  static SecurityQuestion fromJsonModel(Map<String, dynamic> json) => SecurityQuestion.fromJson(json);
}
