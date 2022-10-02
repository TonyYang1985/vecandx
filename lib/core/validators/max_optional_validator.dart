import 'package:reactive_forms/reactive_forms.dart';

/// validator that requires the optional control's value to be less than or equal to a
/// provided value.
class OptionalMaxValidator<T> extends Validator<dynamic> {
  final T max;

  /// Constructs the instance of the validator.
  ///
  /// The argument [max] must not be null.
  OptionalMaxValidator(this.max);

  @override
  Map<String, Object> validate(AbstractControl<dynamic> control) {
    final error = {
      ValidationMessage.max: <String, dynamic>{
        'max': max,
        'actual': control.value,
      },
    };

    if (control.value == null || control.value == '') {
      return null;
    }

    assert(control.value is Comparable<dynamic>,
        'The OptionalMaxValidator validator is expecting a control of type `Comparable` but received a control of type ${control.value.runtimeType}');

    final comparableValue = control.value as Comparable<dynamic>;
    return comparableValue.compareTo(max) <= 0 ? null : error;
  }
}
