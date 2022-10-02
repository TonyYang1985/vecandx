import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

import '../core/locator.dart';
import '../core/services/navigator_service.dart';

class ProviderInjector {
  static List<SingleChildWidget> providers = [
    ..._independentServices,
    ..._dependentServices,
    ..._consumableServices,
  ];

  static final List<SingleChildWidget> _independentServices = [
    Provider.value(value: locator<NavigatorService>()),
  ];

  static final List<SingleChildWidget> _dependentServices = [];

  static final List<SingleChildWidget> _consumableServices = [];
}
