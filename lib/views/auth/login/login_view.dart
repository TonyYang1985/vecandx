library login_view;

import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/widgets.dart';
import '../models/login.dart';
import './login_view_model.dart';

part 'login_desktop.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _LoginDesktop(model),
        desktop: _LoginDesktop(model),
        tablet: _LoginDesktop(model),
      ),
    );
  }
}
