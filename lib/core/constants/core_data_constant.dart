import 'package:flutter/material.dart';

class CoreData {
  // It is required to change every time
  static const appVersion = 'v0.0.23';
  static const lowRiskResult =
      'Low risk score indicative of bladder cancer absence,\nfollow-up with other urological examinations recommended.';
  static const highRiskResult = 'High risk score indicative of bladder cancer presence,\ncystoscopy recommended.';

  static const securityQuestions = [
    DropdownMenuItem(value: 1, child: Text('What primary school did you attend?')),
    DropdownMenuItem(value: 2, child: Text('In what town or city was your first full time job?')),
    DropdownMenuItem(value: 3, child: Text("What is your mother's maiden name?")),
    DropdownMenuItem(value: 4, child: Text('What was your favorite elementary school teacher’s name?')),
    DropdownMenuItem(value: 5, child: Text('What was your childhood nickname?')),
    DropdownMenuItem(value: 6, child: Text('In what city does your nearest sibling live?')),
    DropdownMenuItem(value: 7, child: Text('What is the name of your favorite childhood friend?')),
  ];
  static final dateOfBirthStartRange = DateTime(1930);
  static final cutOffValue = 0.58;
}
