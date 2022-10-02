library role_list_view;

import 'package:flutter/rendering.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/constants/modules_constant.dart';
import '../../../core/extensions/authorization_extension.dart';
import '../../../core/models/permission.dart';
import '../../../widgets/widgets.dart';
import '../models/role_module.dart';
import 'role_module_list_view_model.dart';

part 'role_module_list_desktop.dart';

class RoleModuleListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoleModuleListViewModel>.reactive(
      viewModelBuilder: () => RoleModuleListViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _RoleModuleListDesktop(model),
        desktop: _RoleModuleListDesktop(model),
        tablet: _RoleModuleListDesktop(model),
      ),
    );
  }
}
