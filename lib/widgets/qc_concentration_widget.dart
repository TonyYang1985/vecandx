import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QcConcentrationWidget extends StatefulWidget {
  final FormGroup formGroup;
  final String controlName;
  final double minValue;
  final double maxValue;
  final String labelText;

  QcConcentrationWidget({
    @required this.formGroup,
    @required this.controlName,
    @required this.minValue,
    @required this.maxValue,
    @required this.labelText,
  });

  @override
  _QcConcentrationWidgetState createState() => _QcConcentrationWidgetState();
}

class _QcConcentrationWidgetState extends State<QcConcentrationWidget> {
  bool _isChecked = false;
  bool _isEmpty = true;

  StreamSubscription<dynamic> _subscription;

  @override
  void initState() {
    Future.delayed(Duration(), () {
      final formGroup = widget.formGroup;

      _subscription = formGroup.control(widget.controlName).valueChanges.listen((value) {
        try {
          if (value != null) {
            if ((widget.minValue <= value) && (value <= widget.maxValue)) {
              setState(() => _isChecked = true);
            } else {
              setState(() => _isChecked = false);
            }
            setState(() => _isEmpty = false);
          } else {
            setState(() {
              _isEmpty = true;
              _isChecked = false;
            });
          }
        } catch (e) {
          print(e);
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      validationMessages: (control) => {
        'min': 'The QC value must be in the range',
        'max': 'The QC value is out of range',
      },
      formControlName: widget.controlName,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]'))],
      decoration: InputDecoration(
        isDense: true,
        labelText: widget.labelText,
        border: OutlineInputBorder(),
        suffixIcon: Icon(
          _isChecked
              ? Icons.check_circle
              : !_isEmpty
                  ? Icons.highlight_off
                  : null,
          color: _isChecked ? Colors.green : Colors.red,
        ),
        suffixText: 'pg/mL',
      ),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
