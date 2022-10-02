library test_edit_view;

import 'package:flutter/rendering.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/widgets.dart';
import '../../../core/locator.dart';
import '../../../core/validators/custom_validators.dart';
import '../../../core/services/calculation_service.dart';
import '../../../core/accessors/datetime_value_format_accessor.dart';
import '../../../core/constants/core_data_constant.dart';
import '../../common/ask_password_dialog/ask_password_dialog.dart';
import '../models/patient_test.dart';
import './test_edit_view_model.dart';

part 'test_edit_desktop.dart';

class TestEditView extends StatelessWidget {
  final calculationService = locator<CalculationService>();

  @override
  Widget build(BuildContext context) {
    final int testId = ModalRoute.of(context).settings.arguments;
    return ViewModelBuilder<TestEditViewModel>.reactive(
      viewModelBuilder: () => TestEditViewModel(),
      onModelReady: (model) => model.initialise(testId),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _TestEditDesktop(model),
        desktop: _TestEditDesktop(model),
        tablet: _TestEditDesktop(model),
      ),
    );
  }
}
