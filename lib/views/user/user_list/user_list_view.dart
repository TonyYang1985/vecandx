library user_list_view;

import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/constants/modules_constant.dart';
import '../../../core/models/permission.dart';
import '../../../core/constants/date_format_constant.dart';
import '../../../core/extensions/authorization_extension.dart';
import '../../../widgets/widgets.dart';
import '../models/user.dart';
import './user_list_view_model.dart';

part 'user_list_desktop.dart';

class UserListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserListViewModel>.reactive(
      viewModelBuilder: () => UserListViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _UserListDesktop(model),
        desktop: _UserListDesktop(model),
        tablet: _UserListDesktop(model),
      ),
    );
  }
}
