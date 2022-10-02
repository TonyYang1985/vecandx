library role_add_view;

import 'package:flutter/rendering.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/widgets.dart';
import '../models/role_add.dart';
import './role_add_view_model.dart';

part 'role_add_desktop.dart';

class RoleAddView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoleAddViewModel>.reactive(
      viewModelBuilder: () => RoleAddViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _RoleAddDesktop(model),
        desktop: _RoleAddDesktop(model),
        tablet: _RoleAddDesktop(model),
      ),
    );
  }
}
