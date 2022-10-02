import 'package:meta/meta.dart';

class SecurityAnswer {
  final String userName;
  final int question;
  final String answer;
  int retryCount;

  SecurityAnswer({
    @required this.userName,
    @required this.question,
    @required this.answer,
    @required this.retryCount,
  });

  factory SecurityAnswer.fromJson(Map<String, dynamic> json) {
    return SecurityAnswer(
      userName: json['userName'],
      question: json['question'],
      answer: json['answer'],
      retryCount: json['retryCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'question': question,
      'answer': answer,
      'retryCount': retryCount,
    };
  }
}
