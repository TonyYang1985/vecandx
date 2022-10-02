library role_module_assign_view;

import 'package:flutter/rendering.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/models/permission.dart';
import '../../../widgets/widgets.dart';
import '../models/role_module.dart';
import '../models/role_module_add.dart';
import 'role_module_assign_view_model.dart';

part 'role_module_assign_desktop.dart';

class RoleModuleAssignView extends StatelessWidget {
  final RoleModule roleModule;

  const RoleModuleAssignView({Key key, this.roleModule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoleModuleAssignViewModel>.reactive(
      viewModelBuilder: () => RoleModuleAssignViewModel(),
      onModelReady: (model) => model.initialise(assignment: roleModule),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _RoleModuleAssignDesktop(model),
        desktop: _RoleModuleAssignDesktop(model),
        tablet: _RoleModuleAssignDesktop(model),
      ),
    );
  }
}
