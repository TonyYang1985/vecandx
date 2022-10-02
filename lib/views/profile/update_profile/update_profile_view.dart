library change_password_view;

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../core/constants/modules_constant.dart';
import '../../../core/models/permission.dart';
import '../../../core/extensions/authorization_extension.dart';
import '../../../widgets/widgets.dart';
import '../models/profile.dart';
import './update_profile_view_model.dart';

part 'update_profile_desktop.dart';

class UpdateProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateProfileViewModel>.reactive(
      viewModelBuilder: () => UpdateProfileViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _UpdateProfileDesktop(model),
        desktop: _UpdateProfileDesktop(model),
        tablet: _UpdateProfileDesktop(model),
      ),
    );
  }
}
