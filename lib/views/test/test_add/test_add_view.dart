library test_add_view;

import 'package:flutter/rendering.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/locator.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/validators/custom_validators.dart';
import '../../../core/services/calculation_service.dart';
import '../../../core/accessors/datetime_value_format_accessor.dart';
import '../../../core/constants/core_data_constant.dart';
import '../../../widgets/widgets.dart';
import '../../common/ask_password_dialog/ask_password_dialog.dart';
import '../models/patient_test.dart';
import './test_add_view_model.dart';

part 'test_add_desktop.dart';

class TestAddView extends StatelessWidget {
  final calculationService = locator<CalculationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TestAddViewModel>.reactive(
      viewModelBuilder: () => TestAddViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _TestAddDesktop(model),
        desktop: _TestAddDesktop(model),
        tablet: _TestAddDesktop(model),
      ),
    );
  }
}
