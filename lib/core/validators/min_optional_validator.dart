import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the optional control's value to be greater than or equal
/// to a provided value.
class OptionalMinValidator<T> extends Validator<dynamic> {
  final T min;

  /// Constructs the instance of the validator.
  ///
  /// The argument [min] must not be null.
  OptionalMinValidator(this.min);

  @override
  Map<String, Object> validate(AbstractControl<dynamic> control) {
    final error = {
      ValidationMessage.min: <String, dynamic>{
        'min': min,
        'actual': control.value,
      },
    };

    if (control.value == null || control.value == '') {
      return null;
    }

    assert(control.value is Comparable<dynamic>,
        'The OptionalMinValidator validator is expecting a control of type `Comparable` but received a control of type ${control.value.runtimeType}');

    final comparableValue = control.value as Comparable<dynamic>;
    return comparableValue.compareTo(min) >= 0 ? null : error;
  }
}
