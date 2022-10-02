library create_account_view;

import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/validators/custom_validators.dart';
import '../../../widgets/widgets.dart';
import '../models/account.dart';
import './create_account_view_model.dart';

part 'create_account_desktop.dart';

class CreateAccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateAccountViewModel>.reactive(
      viewModelBuilder: () => CreateAccountViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _CreateAccountDesktop(model),
        desktop: _CreateAccountDesktop(model),
        tablet: _CreateAccountDesktop(model),
      ),
    );
  }
}
