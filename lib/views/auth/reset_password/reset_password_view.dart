library reset_password_view;

import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/validators/custom_validators.dart';
import '../../../widgets/widgets.dart';
import '../models/password_reset.dart';
import '../models/password_reset_token.dart';
import './reset_password_view_model.dart';

part 'reset_password_desktop.dart';

class ResetPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PasswordResetToken passwordResetToken = ModalRoute.of(context).settings.arguments;
    return ViewModelBuilder<ResetPasswordViewModel>.reactive(
      viewModelBuilder: () => ResetPasswordViewModel(),
      onModelReady: (model) => model.initialise(passwordResetToken),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _ResetPasswordDesktop(model),
        desktop: _ResetPasswordDesktop(model),
        tablet: _ResetPasswordDesktop(model),
      ),
    );
  }
}
