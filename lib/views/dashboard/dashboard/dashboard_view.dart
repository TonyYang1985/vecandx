library dashboard_view;

import 'package:flutter/rendering.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/extensions/module_icons_extension.dart';
import '../../../widgets/widgets.dart';
import './dashboard_view_model.dart';

part 'dashboard_desktop.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: _DashboardDesktop(model),
        desktop: _DashboardDesktop(model),
        tablet: _DashboardDesktop(model),
      ),
    );
  }
}
