import 'package:meta/meta.dart';

class DropdownItem<T> {
  final T value;
  final String label;

  DropdownItem({
    @required this.value,
    @required this.label,
  });

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'label': label,
    };
  }

  factory DropdownItem.fromJson(Map<String, dynamic> json) {
    return DropdownItem(
      value: json['value'],
      label: json['label'],
    );
  }

  static DropdownItem<dynamic> fromJsonModel(Map<String, dynamic> json) => DropdownItem.fromJson(json);
}
