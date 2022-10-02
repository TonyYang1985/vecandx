import 'package:reactive_forms/reactive_forms.dart';

import 'max_optional_validator.dart';
import 'min_optional_validator.dart';

class CustomValidators {
  static Map<String, dynamic> validatePassword(AbstractControl<dynamic> control) {
    final password = control.value;

    final validationErrors = {
      'lowercase': true,
      'uppercase': true,
      'digit': true,
      'special': true,
      'min': true,
    };

    if (password == null || password == '') {
      return {'validationErrors': validationErrors};
    }

    // Minimum one uppercase, one lowercase, one digit, one specical character and at least 8 digits
    final passwordPattern = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');

    if (!passwordPattern.hasMatch(password)) {
      validationErrors['lowercase'] = !password.contains(RegExp('[a-z]'));
      validationErrors['uppercase'] = !password.contains(RegExp('[A-Z]'));
      validationErrors['digit'] = !password.contains(RegExp('[0-9]'));
      validationErrors['special'] = !password.contains(RegExp(r'[#?!@$%^&*-]'));
      validationErrors['min'] = password.length < 8;
      return {'validationErrors': validationErrors};
    }
    return null;
  }

  static ValidatorFunction mustMatch(String controlName, String matchingControlName) {
    return (AbstractControl<dynamic> control) {
      final form = control as FormGroup;

      final formControl = form.control(controlName);
      final matchingFormControl = form.control(matchingControlName);

      if (formControl.value != matchingFormControl.value) {
        matchingFormControl.setErrors({'mustMatch': true});
        matchingFormControl.markAsTouched();
      } else {
        matchingFormControl.setErrors({});
      }
      return null;
    };
  }

  /// Gets a validator that requires the control's value to be greater than
  /// or equal to [min] value.
  ///
  /// The argument [min] must not be null.
  static ValidatorFunction min<T>(T min) => OptionalMinValidator<T>(min).validate;

  /// Gets a validator that requires the control's value to be less than
  /// or equal to [max] value.
  ///
  /// The argument [max] must not be null.
  static ValidatorFunction max<T>(T max) => OptionalMaxValidator<T>(max).validate;
}
