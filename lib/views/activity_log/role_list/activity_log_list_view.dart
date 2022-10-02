library activity_log_list_view;

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
import '../models/activity_log.dart';
import 'activity_log_list_view_model.dart';

part 'activity_log_list_desktop.dart';

class ActivityLogListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ActivityLogListViewModel>.reactive(
      viewModelBuilder: () => ActivityLogListViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _ActivityLogListDesktop(model),
        desktop: _ActivityLogListDesktop(model),
        tablet: _ActivityLogListDesktop(model),
      ),
    );
  }
}
