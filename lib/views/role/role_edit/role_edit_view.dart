library role_edit_view;

import 'package:flutter/rendering.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/widgets.dart';
import '../models/role_edit.dart';
import './role_edit_view_model.dart';

part 'role_edit_desktop.dart';

class RoleEditView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String roleId = ModalRoute.of(context).settings.arguments;
    return ViewModelBuilder<RoleEditViewModel>.reactive(
      viewModelBuilder: () => RoleEditViewModel(),
      onModelReady: (model) => model.initialise(roleId),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _RoleEditDesktop(model),
        desktop: _RoleEditDesktop(model),
        tablet: _RoleEditDesktop(model),
      ),
    );
  }
}
