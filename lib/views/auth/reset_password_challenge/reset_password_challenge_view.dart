library reset_password_challenge_view;

import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/widgets.dart';
import '../models/security_answer.dart';
import './reset_password_challenge_view_model.dart';

part 'reset_password_challenge_desktop.dart';

class ResetPasswordChallengeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetPasswordChallengeViewModel>.reactive(
      viewModelBuilder: () => ResetPasswordChallengeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _ResetPasswordChallengeDesktop(model),
        desktop: _ResetPasswordChallengeDesktop(model),
        tablet: _ResetPasswordChallengeDesktop(model),
      ),
    );
  }
}
