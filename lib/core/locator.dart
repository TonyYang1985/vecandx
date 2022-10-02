import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../views/common/services/common_service.dart';
import '../views/auth/services/auth_service.dart';
import '../views/test/services/test_service.dart';
import '../views/module/services/module_service.dart';
import '../views/role/services/role_service.dart';
import '../views/user/services/user_service.dart';
import '../views/profile/services/profile_service.dart';
import '../views/role_module/services/role_module_service.dart';
import '../views/activity_log/services/activity_log_service.dart';
import './api/api_client.dart';
import './logger.dart';
import './services/navigator_service.dart';
import './services/calculation_service.dart';
import './services/storage_service.dart';

GetIt locator = GetIt.instance;

class LocatorInjector {
  static final Logger _log = getLogger('LocatorInjector');

  static Future<void> setupLocator() async {
    _log.d('Initializing Navigator Service');
    locator.registerLazySingleton(() => NavigatorService());
    locator.registerLazySingleton(() => StorageService());
    locator.registerLazySingleton(() => ApiClient(storageService: locator()));
    locator.registerLazySingleton(() => AuthService(storageService: locator(), client: locator()));
    locator.registerLazySingleton(() => CalculationService(client: locator()));
    locator.registerLazySingleton(() => TestService(client: locator()));
    locator.registerLazySingleton(() => ModuleService(client: locator()));
    locator.registerLazySingleton(() => RoleService(client: locator()));
    locator.registerLazySingleton(() => RoleModuleService(client: locator()));
    locator.registerLazySingleton(() => UserService(client: locator()));
    locator.registerLazySingleton(() => ProfileService(client: locator()));
    locator.registerLazySingleton(() => CommonService(client: locator()));
    locator.registerLazySingleton(() => ActivityLogService(client: locator()));
  }
}
