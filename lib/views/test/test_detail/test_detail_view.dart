library test_detail_view;

import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:vecandx/core/constants/core_data_constant.dart';
import 'package:vecandx/core/constants/date_format_constant.dart';
import 'package:vecandx/core/utils/datetime_util.dart';
import 'package:vecandx/views/test/models/patient_test.dart';
import 'package:vecandx/views/test/models/smoking_status.dart';

import './test_detail_view_model.dart';

part 'test_detail_desktop.dart';

class TestDetailView extends StatelessWidget {
  final PatientTest patientTest;

  const TestDetailView({Key key, this.patientTest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TestDetailViewModel>.reactive(
      viewModelBuilder: () => TestDetailViewModel(),
      onModelReady: (model) => model.initialise(patientTest),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _TestDetailDesktop(model),
        desktop: _TestDetailDesktop(model),
        tablet: _TestDetailDesktop(model),
      ),
    );
  }
}
