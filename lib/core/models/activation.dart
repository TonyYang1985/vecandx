import 'package:meta/meta.dart';

class Activation {
  final dynamic id;
  final bool isActive;

  Activation({
    @required this.id,
    @required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isActive': isActive,
    };
  }

  factory Activation.fromJson(Map<String, dynamic> json) {
    return Activation(
      id: json['id'],
      isActive: json['isActive'],
    );
  }
}
