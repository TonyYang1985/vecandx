library change_password_view;

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/widgets.dart';
import '../../../core/validators/custom_validators.dart';
import '../models/password_change.dart';
import './change_password_view_model.dart';

part 'change_password_desktop.dart';

class ChangePasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
      viewModelBuilder: () => ChangePasswordViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _ChangePasswordDesktop(model),
        desktop: _ChangePasswordDesktop(model),
        tablet: _ChangePasswordDesktop(model),
      ),
    );
  }
}
