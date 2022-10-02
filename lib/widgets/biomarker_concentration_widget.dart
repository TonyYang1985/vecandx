import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class BiomarkerConcentrationWidget extends StatefulWidget {
  final FormGroup formGroup;
  final String controlName;
  final double maxValue;
  final String labelText;
  final Map<String, String> validationMessages;

  BiomarkerConcentrationWidget({
    @required this.formGroup,
    @required this.controlName,
    @required this.maxValue,
    @required this.labelText,
    @required this.validationMessages,
  });

  @override
  _BiomarkerConcentrationWidgetState createState() => _BiomarkerConcentrationWidgetState();
}

class _BiomarkerConcentrationWidgetState extends State<BiomarkerConcentrationWidget> {
  bool _isChecked = false;
  StreamSubscription<dynamic> _subscription;

  @override
  void initState() {
    Future.delayed(Duration(), () {
      final formGroup = widget.formGroup;
      _subscription = formGroup.control(widget.controlName).valueChanges.listen((value) {
        try {
          if (_isChecked && value == null) {
            setState(() => _isChecked = false);
          } else if (_isChecked && value < widget.maxValue) {
            setState(() => _isChecked = false);
          } else if (_isChecked && value > widget.maxValue) {
            setState(() => _isChecked = false);
          } else if (!_isChecked && value == widget.maxValue) {
            setState(() => _isChecked = true);
          }
        } catch (e) {
          print(e);
        }
      });
    });
    widget.validationMessages['max'] = 'Input value exceeds permissible, please tick "Out of range" to continue.';
    widget.validationMessages['min'] = 'Biomarker minimum value is 0';

    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: widget.controlName,
      validationMessages: (control) => widget.validationMessages,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]'))],
      obscureText: _isChecked,
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Type biomarker concentration value',
        labelStyle: TextStyle(fontSize: 20),
        labelText: widget.labelText,
        border: OutlineInputBorder(),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: _isChecked,
              onChanged: (value) {
                setState(() => _isChecked = value);
                widget.formGroup.control(widget.controlName).patchValue(value ? widget.maxValue : null);
              },
            ),
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: Text('Out of range'),
            )
          ],
        ),
        suffixText: 'pg/mL',
      ),
    );
  }
}
