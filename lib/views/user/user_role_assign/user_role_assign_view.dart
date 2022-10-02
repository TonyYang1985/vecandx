library role_add_view;

import 'package:flutter/rendering.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/widgets.dart';
import '../../../core/models/permission.dart';
import '../models/user.dart';
import './user_role_assign_view_model.dart';

part 'user_role_assign_desktop.dart';

class UserRoleAssignView extends StatelessWidget {
  final User user;

  const UserRoleAssignView({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserRoleAssignViewModel>.reactive(
      viewModelBuilder: () => UserRoleAssignViewModel(),
      onModelReady: (model) => model.initialise(user),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _UserRoleAssignDesktop(model),
        desktop: _UserRoleAssignDesktop(model),
        tablet: _UserRoleAssignDesktop(model),
      ),
    );
  }
}
