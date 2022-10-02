import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PasswordValidationWidget extends StatelessWidget {
  final String controlName;

  const PasswordValidationWidget({Key key, this.controlName = 'password'}) : super(key: key);

  Widget _buildValidationRule(bool hasError, String message) {
    return Row(
      children: [
        Icon(
          hasError ? Icons.close : Icons.check,
          color: hasError ? Colors.red : Colors.green,
          size: 16,
        ),
        Text(
          message,
          style: TextStyle(color: hasError ? Colors.red : Colors.green),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        final control = form.control(controlName);
        final hasError = !control.hasError('required') && control.hasError('validationErrors');

        if (hasError) {
          final errors = control.errors['validationErrors'] as Map<String, bool>;
          return Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildValidationRule(errors['uppercase'], 'Required 1 uppercase'),
                _buildValidationRule(errors['lowercase'], 'Required 1 lowercase'),
                _buildValidationRule(errors['digit'], 'Required 1 digit'),
                _buildValidationRule(errors['special'], r'Required 1 special char (#?!@$%^&*-)'),
                _buildValidationRule(errors['min'], 'Minimum length is 8 char'),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
