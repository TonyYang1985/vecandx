library role_list_view;

import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/constants/modules_constant.dart';
import '../../../core/models/permission.dart';
import '../../../core/extensions/authorization_extension.dart';
import '../../../core/constants/date_format_constant.dart';
import '../../../widgets/widgets.dart';
import '../models/role.dart';
import 'role_list_view_model.dart';

part 'role_list_desktop.dart';

class RoleListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoleListViewModel>.reactive(
      viewModelBuilder: () => RoleListViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _RoleListDesktop(model),
        desktop: _RoleListDesktop(model),
        tablet: _RoleListDesktop(model),
      ),
    );
  }
}
