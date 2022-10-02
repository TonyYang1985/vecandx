library test_list_view;

import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vecandx/core/constants/core_data_constant.dart';
import 'package:vecandx/widgets/date_range_widget.dart';

import '../../../core/constants/modules_constant.dart';
import '../../../core/models/permission.dart';
import '../../../core/extensions/authorization_extension.dart';
import '../../../core/constants/date_format_constant.dart';
import '../../../widgets/widgets.dart';
import '../models/patient_test.dart';
import './test_list_view_model.dart';

part 'test_list_desktop.dart';

class TestListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TestListViewModel>.reactive(
      viewModelBuilder: () => TestListViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _TestListDesktop(model),
        desktop: _TestListDesktop(model),
        tablet: _TestListDesktop(model),
      ),
    );
  }
}
